import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  Logger,
} from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { AuditService } from '@modules/audit/application/audit.service';
import {
  AuditCategory,
  AuditAction,
  AuditStatus,
  AuditSeverity,
} from '@modules/audit/domain/audit-event.entity';
import { REQUEST_CONTEXT_KEY } from '../context/request-context';

interface AuditContext {
  actorUserId?: number;
  actorEmail?: string;
  actorRole?: string;
  requestId?: string;
  correlationId?: string;
}

/**
 * Audit Interceptor - Logs all HTTP requests/responses
 * Captures: user, action, resource, result, timestamp
 */
@Injectable()
export class AuditInterceptor implements NestInterceptor {
  private readonly logger = new Logger('AuditInterceptor');

  constructor(private auditService: AuditService) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const { method, url, user, ip } = request;

    // Extract audit context from request
    const auditCtx = this.extractAuditContext(request);

    // Determine event code, category, action, severity
    const eventInfo = this.resolveEventInfo(method, url);

    const startTime = Date.now();

    return next.handle().pipe(
      tap(() => {
        // Log SUCCESS
        this.auditService.logEvent({
          ...eventInfo,
          status: AuditStatus.SUCCESS,
          actorUserId: auditCtx.actorUserId,
          actorEmail: auditCtx.actorEmail,
          actorRole: auditCtx.actorRole,
          route: url,
          method,
          ip: ip || null,
          userAgent: request.get('user-agent') || null,
          requestId: auditCtx.requestId || null,
          correlationId: auditCtx.correlationId || null,
          metadata: {
            responseTime: `${Date.now() - startTime}ms`,
          },
        });
      }),
      catchError((error) => {
        // Log FAIL or DENIED based on status
        const status =
          error?.status === 403 || error?.status === 401
            ? AuditStatus.DENIED
            : AuditStatus.FAIL;

        const severity = status === AuditStatus.DENIED ? AuditSeverity.HIGH : AuditSeverity.WARN;

        this.auditService.logEvent({
          ...eventInfo,
          action: AuditAction.EXECUTE, // Fallback for errors
          status,
          severity,
          actorUserId: auditCtx.actorUserId,
          actorEmail: auditCtx.actorEmail,
          actorRole: auditCtx.actorRole,
          route: url,
          method,
          ip: ip || null,
          userAgent: request.get('user-agent') || null,
          requestId: auditCtx.requestId || null,
          correlationId: auditCtx.correlationId || null,
          errorMessage: error?.message || error?.response?.message || 'Unknown error',
        });

        return throwError(() => error);
      }),
    );
  }

  /**
   * Extract audit context from request (user info, correlation IDs)
   */
  private extractAuditContext(request: any): AuditContext {
    const user = request.user;
    let correlationId = request.headers['x-correlation-id'];
    let requestId = request.headers['x-request-id'];

    // Fallback: use context if not in headers
    if (!correlationId || !requestId) {
      const ctx = request[REQUEST_CONTEXT_KEY];
      if (ctx) {
        correlationId = correlationId || ctx.correlationId;
        requestId = requestId || ctx.requestId;
      }
    }

    return {
      actorUserId: user?.userId,
      actorEmail: user?.email,
      actorRole: user?.role,
      correlationId,
      requestId,
    };
  }

  /**
   * Resolve event information based on route and method
   * Maps HTTP endpoint to audit event code, category, action, severity
   */
  private resolveEventInfo(
    method: string,
    url: string,
  ): {
    eventCode: string;
    category: AuditCategory;
    action: AuditAction;
    severity: AuditSeverity;
  } {
    // Default: low severity for unmatched routes
    let eventCode = `SYSTEM.${method}`;
    let category = AuditCategory.SYSTEM;
    let action = AuditAction.EXECUTE;
    let severity = AuditSeverity.INFO;

    // Extract path without query params
    const path = url.split('?')[0];

    // AUTH routes
    if (path.includes('/auth/login')) {
      eventCode = 'AUTH.LOGIN.ATTEMPT';
      category = AuditCategory.AUTH;
      action = AuditAction.LOGIN;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/auth/register')) {
      eventCode = 'AUTH.REGISTER.ATTEMPT';
      category = AuditCategory.AUTH;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/auth/refresh')) {
      eventCode = 'AUTH.REFRESH.ATTEMPT';
      category = AuditCategory.AUTH;
      action = AuditAction.REFRESH;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/auth/change-password')) {
      eventCode = 'AUTH.PASSWORD_CHANGE.ATTEMPT';
      category = AuditCategory.AUTH;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.CRITICAL;
    }
    // USERS routes
    else if (path.includes('/users') && method === 'GET' && !path.includes('/users/')) {
      eventCode = 'USERS.LIST.READ';
      category = AuditCategory.USERS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/users') && method === 'GET') {
      eventCode = 'USERS.ITEM.READ';
      category = AuditCategory.USERS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/users') && method === 'POST') {
      eventCode = 'USERS.CREATE';
      category = AuditCategory.USERS;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/users') && method === 'PATCH') {
      eventCode = 'USERS.UPDATE';
      category = AuditCategory.USERS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/users') && method === 'DELETE') {
      eventCode = 'USERS.DELETE';
      category = AuditCategory.USERS;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/users') && path.includes('/toggle-active')) {
      eventCode = 'USERS.TOGGLE_ACTIVE';
      category = AuditCategory.USERS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/users') && path.includes('/permissions')) {
      eventCode =
        method === 'GET' ? 'USERS.PERMISSIONS.READ' : 'USERS.PERMISSIONS.UPDATE';
      category = AuditCategory.USERS;
      action = method === 'GET' ? AuditAction.READ : AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    }
    // PRODUCERS routes
    else if (path.includes('/producers') && method === 'GET' && !path.includes('/producers/')) {
      eventCode = 'PRODUCERS.LIST.READ';
      category = AuditCategory.PRODUCERS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/producers') && method === 'GET') {
      eventCode = 'PRODUCERS.ITEM.READ';
      category = AuditCategory.PRODUCERS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/producers') && method === 'POST' && !path.includes('/bank-accounts')) {
      eventCode = 'PRODUCERS.CREATE';
      category = AuditCategory.PRODUCERS;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/producers') && method === 'PUT' && !path.includes('/bank-accounts')) {
      eventCode = 'PRODUCERS.UPDATE';
      category = AuditCategory.PRODUCERS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/producers') && method === 'DELETE' && !path.includes('/bank-accounts')) {
      eventCode = 'PRODUCERS.DELETE';
      category = AuditCategory.PRODUCERS;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/bank-accounts')) {
      eventCode =
        method === 'POST'
          ? 'PRODUCERS.BANK_ACCOUNT.ADD'
          : 'PRODUCERS.BANK_ACCOUNT.REMOVE';
      category = AuditCategory.PRODUCERS;
      action = method === 'POST' ? AuditAction.CREATE : AuditAction.DELETE;
      severity = AuditSeverity.HIGH;
    }
    // OPERATIONS routes
    else if (path.includes('/operations/receptions') && method === 'GET' && !path.includes('/receptions/')) {
      eventCode = 'OPS.RECEPTIONS.LIST.READ';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/operations/receptions/export')) {
      eventCode = 'OPS.RECEPTIONS.EXPORT';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.EXPORT;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/operations/receptions') && method === 'POST' && !path.includes('/analysis')) {
      eventCode = 'OPS.RECEPTIONS.CREATE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/operations/receptions') && method === 'PUT') {
      eventCode = 'OPS.RECEPTIONS.UPDATE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/rice-price')) {
      eventCode = 'OPS.RECEPTIONS.RICE_PRICE.UPDATE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/calculate-discounts')) {
      eventCode = 'OPS.RECEPTIONS.CALCULATE_DISCOUNTS';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.CALCULATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/settle')) {
      eventCode = 'OPS.RECEPTIONS.SETTLE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.EXECUTE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/operations/receptions') && method === 'DELETE') {
      eventCode = 'OPS.RECEPTIONS.DELETE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/analysis') && method === 'GET') {
      eventCode = 'OPS.ANALYSIS.READ';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/analysis') && method === 'POST') {
      eventCode = 'OPS.ANALYSIS.CREATE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/analysis') && method === 'PUT') {
      eventCode = 'OPS.ANALYSIS.UPDATE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/analysis') && method === 'DELETE') {
      eventCode = 'OPS.ANALYSIS.DELETE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/dry-percent')) {
      eventCode = 'OPS.ANALYSIS.DRY_PERCENT.UPDATE';
      category = AuditCategory.OPERATIONS;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    }
    // FINANCES routes
    else if (path.includes('/finances/advances') && method === 'GET' && !path.includes('/advances/')) {
      eventCode = 'FINANCE.ADVANCES.LIST.READ';
      category = AuditCategory.FINANCE;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/finances/advances/export')) {
      eventCode = 'FINANCE.ADVANCES.EXPORT';
      category = AuditCategory.FINANCE;
      action = AuditAction.EXPORT;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/finances/advances') && method === 'POST') {
      eventCode = 'FINANCE.ADVANCES.CREATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/advances') && method === 'PUT') {
      eventCode = 'FINANCE.ADVANCES.UPDATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/advances') && method === 'PATCH') {
      eventCode = 'FINANCE.ADVANCES.UPDATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/advances') && method === 'DELETE') {
      eventCode = 'FINANCE.ADVANCES.DELETE';
      category = AuditCategory.FINANCE;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/interest')) {
      eventCode = 'FINANCE.ADVANCES.INTEREST.CALCULATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.CALCULATE;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/finances/transactions') && method === 'GET' && !path.includes('/transactions/')) {
      eventCode = 'FINANCE.TRANSACTIONS.LIST.READ';
      category = AuditCategory.FINANCE;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/finances/transactions') && method === 'POST') {
      eventCode = 'FINANCE.TRANSACTIONS.CREATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/transactions') && method === 'PUT') {
      eventCode = 'FINANCE.TRANSACTIONS.UPDATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/transactions') && method === 'DELETE') {
      eventCode = 'FINANCE.TRANSACTIONS.DELETE';
      category = AuditCategory.FINANCE;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/finances/settlements') && method === 'GET' && !path.includes('/settlements/')) {
      eventCode = 'FINANCE.SETTLEMENTS.LIST.READ';
      category = AuditCategory.FINANCE;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/settlements/candidates')) {
      eventCode = 'FINANCE.SETTLEMENTS.CANDIDATES.READ';
      category = AuditCategory.FINANCE;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    } else if (path.includes('/finances/settlements') && method === 'POST' && !path.includes('/calculate') && !path.includes('/complete') && !path.includes('/cancel')) {
      eventCode = 'FINANCE.SETTLEMENTS.CREATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.CREATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/settlements') && method === 'PUT') {
      eventCode = 'FINANCE.SETTLEMENTS.UPDATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.UPDATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/finances/settlements') && method === 'DELETE') {
      eventCode = 'FINANCE.SETTLEMENTS.DELETE';
      category = AuditCategory.FINANCE;
      action = AuditAction.DELETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/calculate')) {
      eventCode = 'FINANCE.SETTLEMENTS.CALCULATE';
      category = AuditCategory.FINANCE;
      action = AuditAction.CALCULATE;
      severity = AuditSeverity.HIGH;
    } else if (path.includes('/complete')) {
      eventCode = 'FINANCE.SETTLEMENTS.COMPLETE';
      category = AuditCategory.FINANCE;
      action = AuditAction.COMPLETE;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/cancel')) {
      eventCode = 'FINANCE.SETTLEMENTS.CANCEL';
      category = AuditCategory.FINANCE;
      action = AuditAction.CANCEL;
      severity = AuditSeverity.CRITICAL;
    } else if (path.includes('/pending-balance')) {
      eventCode = 'FINANCE.PRODUCERS.PENDING_BALANCE.READ';
      category = AuditCategory.FINANCE;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    }
    // CONFIGURATION routes
    else if (path.includes('/configuration')) {
      if (path.includes('/rice-types')) {
        eventCode =
          method === 'GET' ? 'CONFIG.RICE_TYPES.READ' : `CONFIG.RICE_TYPES.${method}`;
        category = AuditCategory.CONFIG;
        action = method === 'GET' ? AuditAction.READ : AuditAction.CREATE;
        severity = method === 'DELETE' ? AuditSeverity.CRITICAL : AuditSeverity.INFO;
      } else if (path.includes('/seasons')) {
        eventCode =
          method === 'GET' ? 'CONFIG.SEASONS.READ' : `CONFIG.SEASONS.${method}`;
        category = AuditCategory.CONFIG;
        action = method === 'GET' ? AuditAction.READ : AuditAction.CREATE;
        severity = method === 'DELETE' ? AuditSeverity.CRITICAL : AuditSeverity.INFO;
      } else if (path.includes('/templates')) {
        eventCode =
          method === 'GET' ? 'CONFIG.TEMPLATES.READ' : `CONFIG.TEMPLATES.${method}`;
        category = AuditCategory.CONFIG;
        action = method === 'GET' ? AuditAction.READ : AuditAction.CREATE;
        severity = method === 'DELETE' ? AuditSeverity.CRITICAL : AuditSeverity.INFO;
      } else if (path.includes('/analysis-params')) {
        eventCode =
          method === 'GET' ? 'CONFIG.ANALYSIS_PARAMS.READ' : `CONFIG.ANALYSIS_PARAMS.${method}`;
        category = AuditCategory.CONFIG;
        action = method === 'GET' ? AuditAction.READ : AuditAction.CREATE;
        severity = method === 'DELETE' ? AuditSeverity.CRITICAL : AuditSeverity.INFO;
      } else if (path.includes('/roles') || path.includes('/banks')) {
        eventCode = 'CONFIG.READ';
        category = AuditCategory.CONFIG;
        action = AuditAction.READ;
        severity = AuditSeverity.INFO;
      }
    }
    // ANALYTICS routes
    else if (path.includes('/analytics')) {
      eventCode = 'ANALYTICS.READ';
      category = AuditCategory.ANALYTICS;
      action = AuditAction.READ;
      severity = AuditSeverity.INFO;
    }

    return { eventCode, category, action, severity };
  }
}

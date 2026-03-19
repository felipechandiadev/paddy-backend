import { PermissionEnum, RoleEnum } from '@shared/enums';

/**
 * Permisos obligatorios que siempre deben estar habilitados para todos los usuarios.
 * No deben aparecer en la UI de administración de permisos.
 */
export const ALWAYS_GRANTED_PERMISSIONS: PermissionEnum[] = [
  PermissionEnum.ANALYSIS_RECORDS_VIEW,
  PermissionEnum.ANALYSIS_RECORDS_CREATE,
  PermissionEnum.ANALYSIS_RECORDS_UPDATE,

  // Servicios de liquidación: siempre habilitados para todos los usuarios.
  // No aparecen en el editor de permisos del frontend.
  PermissionEnum.SETTLEMENT_SERVICES_VIEW,
  PermissionEnum.SETTLEMENT_SERVICES_CREATE,
  PermissionEnum.SETTLEMENT_SERVICES_UPDATE,
  PermissionEnum.SETTLEMENT_SERVICES_DELETE,
];

/**
 * Permisos por defecto para cada rol.
 * ADMIN tiene todos los permisos.
 * CONSULTANT tiene un subset de solo lectura + operaciones básicas.
 *
 * Los overrides individuales por usuario (user_permission_overrides)
 * se aplican ENCIMA de estos defaults.
 */
export const DEFAULT_ROLE_PERMISSIONS: Record<RoleEnum, PermissionEnum[]> = {
  [RoleEnum.ADMIN]: Object.values(PermissionEnum),

  [RoleEnum.CONSULTANT]: [
    // Usuarios: solo ver
    PermissionEnum.USERS_VIEW,

    // Productores: CRUD completo
    PermissionEnum.PRODUCERS_VIEW,
    PermissionEnum.PRODUCERS_CREATE,
    PermissionEnum.PRODUCERS_UPDATE,
    PermissionEnum.PRODUCERS_DELETE,

    // Configuración: solo ver
    PermissionEnum.RICE_TYPES_VIEW,
    PermissionEnum.SEASONS_VIEW,
    PermissionEnum.TEMPLATES_VIEW,
    PermissionEnum.ANALYSIS_PARAMS_VIEW,

    // Recepciones: CRUD completo
    PermissionEnum.RECEPTIONS_VIEW,
    PermissionEnum.RECEPTIONS_CREATE,
    PermissionEnum.RECEPTIONS_UPDATE,
    PermissionEnum.RECEPTIONS_CANCEL,

    // Análisis: CRUD completo
    PermissionEnum.ANALYSIS_RECORDS_VIEW,
    PermissionEnum.ANALYSIS_RECORDS_CREATE,
    PermissionEnum.ANALYSIS_RECORDS_UPDATE,

    // Anticipos: crear/editar/cancelar, pero NO cambiar tasa de interés
    PermissionEnum.ADVANCES_VIEW,
    PermissionEnum.ADVANCES_CREATE,
    PermissionEnum.ADVANCES_UPDATE,
    PermissionEnum.ADVANCES_CANCEL,

    // Transacciones: solo ver
    PermissionEnum.TRANSACTIONS_VIEW,

    // Liquidaciones: crear y guardar borrador, pero NO completar ni cancelar
    PermissionEnum.SETTLEMENTS_VIEW,
    PermissionEnum.SETTLEMENTS_CREATE,
    PermissionEnum.SETTLEMENTS_SAVE,

    // Analíticas: ver reportes
    PermissionEnum.ANALYTICS_VIEW,
  ],
};

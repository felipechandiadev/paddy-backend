/**
 * Roles available en el sistema
 * Admin: Acceso total
 */
export enum RoleEnum {
  ADMIN = 'ADMIN',
  CONSULTANT = 'CONSULTANT',
}

/**
 * Estados de una Recepción
 */
export enum ReceptionStatusEnum {
  CANCELLED = 'cancelled',        // Recepción cancelada
  ANALYZED = 'analyzed',          // Análisis completado
  SETTLED = 'settled',            // Liquidado (pagado)
}

/**
 * Estados de una Liquidación
 */
export enum SettlementStatusEnum {
  DRAFT = 'draft',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

/**
 * Estados de un Anticipo
 */
export enum AdvanceStatusEnum {
  PAID = 'paid',                  // Pagado (pendiente de liquidar)
  SETTLED = 'settled',            // Descontado
  CANCELLED = 'cancelled',        // Anulado
}

/**
 * Tipo de Transacción (Movimientos de dinero)
 */
export enum TransactionTypeEnum {
  ADVANCE = 'advance',            // Anticipo pre-cosecha
  PAYMENT = 'payment',            // Pago por recepción
  DEDUCTION = 'deduction',        // Descuento (secado, impurezas, etc.)
  INTEREST = 'interest',          // Interés por financiamiento
  REFUND = 'refund',              // Devolución
  SETTLEMENT = 'settlement',      // Liquidación final
}

/**
 * Tipo de Cuenta Bancaria
 */
export enum BankAccountTypeEnum {
  CORRIENTE = 'corriente',        // Cuenta corriente
  VISTA = 'vista',                // Cuenta vista
  AHORRO = 'ahorro',              // Cuenta de ahorro
  RUT = 'rut',                    // Cuenta RUT
}

/**
 * Nombre de Banco
 */
export enum BankNameEnum {
  BANCO_CHILE = 'Banco de Chile',
  BANCO_ESTADO = 'Banco del Estado de Chile',
  BANCO_SANTANDER = 'Banco Santander Chile',
  BANCO_BCI = 'Banco de Crédito e Inversiones',
  BANCO_FALABELLA = 'Banco Falabella',
  BANCO_SECURITY = 'Banco Security',
  BANCO_CREDICHILE = 'Banco CrediChile',
  BANCO_ITAU = 'Banco Itaú Corpbanca',
  BANCO_SCOTIABANK = 'Scotiabank Chile',
  BANCO_CONSORCIO = 'Banco Consorcio',
  BANCO_RIPLEY = 'Banco Ripley',
  BANCO_INTERNACIONAL = 'Banco Internacional',
  BANCO_BICE = 'Banco BICE',
  BANCO_PARIS = 'Banco Paris',
  BANCO_MERCADO_PAGO = 'Banco Mercado Pago',
  OTRO = 'Otro',
}

/**
 * Método de Pago
 */
export enum PaymentMethodEnum {
  TRANSFER = 'transfer',          // Transferencia bancaria
  CHECK = 'check',                // Cheque
  CASH = 'cash',                  // Efectivo
}

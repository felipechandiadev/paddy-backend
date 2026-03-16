import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import * as dotenv from 'dotenv';

// Cargar .env
dotenv.config();

// Importar módulos de dominio
import { AuthModule } from './modules/auth/auth.module';
import { UsersModule } from './modules/users/users.module';
import { ProducersModule } from './modules/producers/producers.module';
import { ConfigurationModule } from './modules/configuration/configuration.module';
import { OperationsModule } from './modules/operations/operations.module';
import { FinancesModule } from './modules/finances/finances.module';
import { AnalyticsModule } from './modules/analytics/analytics.module';

// Importar entidades
import { User } from './modules/users/domain/user.entity';
import { Producer } from './modules/producers/domain/producer.entity';
import {
  RiceType,
  Season,
  Template,
  AnalysisParam,
} from './modules/configuration/domain/configuration.entity';
import {
  Reception,
  AnalysisRecord,
} from './modules/operations/domain/operations.entity';
import {
  Advance,
  Transaction,
  Settlement,
  SettlementReceptionSnapshot,
} from './modules/finances/domain/finances.entity';

const isDatabaseSslRequired =
  process.env.DATABASE_SSL_MODE?.toUpperCase() === 'REQUIRED';
const isDatabaseSslEnabled =
  isDatabaseSslRequired || process.env.DATABASE_SSL === 'true';
const sslRejectUnauthorized =
  process.env.DATABASE_SSL_REJECT_UNAUTHORIZED !== 'false';
const sslCa = process.env.DATABASE_SSL_CA?.replace(/\\n/g, '\n');

const databaseSslConfig = isDatabaseSslEnabled
  ? {
      ssl: sslCa
        ? { rejectUnauthorized: sslRejectUnauthorized, ca: sslCa }
        : { rejectUnauthorized: sslRejectUnauthorized },
    }
  : {};

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: process.env.DATABASE_HOST || 'localhost',
      port: parseInt(process.env.DATABASE_PORT || '3306'),
      username: process.env.DATABASE_USER || 'root',
      password: process.env.DATABASE_PASSWORD || 'redbull90',
      database: process.env.DATABASE_NAME || 'paddy',
      ...databaseSslConfig,
      entities: [
        User,
        Producer,
        RiceType,
        Season,
        Template,
        AnalysisParam,
        Reception,
        AnalysisRecord,
        Advance,
        Transaction,
        Settlement,
        SettlementReceptionSnapshot,
      ],
      synchronize:
        process.env.TYPEORM_SYNCHRONIZE === 'true' &&
        process.env.NODE_ENV === 'development',
      logging: process.env.NODE_ENV === 'development',
      dropSchema: process.env.NODE_ENV === 'test',
    }),
    AuthModule,
    UsersModule,
    ProducersModule,
    ConfigurationModule,
    OperationsModule,
    FinancesModule,
    AnalyticsModule,
  ],
  providers: [],
})
export class AppModule {}

import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigurationService } from './application/configuration.service';
import { ConfigurationController } from './presentation/configuration.controller';
import {
  RiceType,
  Season,
  Template,
  AnalysisParam,
} from './domain/configuration.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([RiceType, Season, Template, AnalysisParam]),
  ],
  providers: [ConfigurationService],
  controllers: [ConfigurationController],
  exports: [ConfigurationService],
})
export class ConfigurationModule {}

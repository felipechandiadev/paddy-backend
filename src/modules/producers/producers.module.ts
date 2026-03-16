import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProducersService } from './application/producers.service';
import { ProducersController } from './presentation/producers.controller';
import { Producer } from './domain/producer.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Producer])],
  providers: [ProducersService],
  controllers: [ProducersController],
  exports: [ProducersService],
})
export class ProducersModule {}

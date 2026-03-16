import {
  Inject,
  Injectable,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, IsNull } from 'typeorm';
import { Producer, BankAccount } from '../domain/producer.entity';
import { validateAndFormatRut } from '@shared/utils/helpers';

@Injectable()
export class ProducersService {
  constructor(
    @InjectRepository(Producer)
    private producersRepository: Repository<Producer>,
  ) {}

  async createProducer(createProducerDto: Partial<Producer>) {
    // Validar RUT
    try {
      const formattedRut = validateAndFormatRut(createProducerDto.rut);
      createProducerDto.rut = formattedRut;
    } catch (error) {
      throw new BadRequestException(error.message);
    }

    const producer = this.producersRepository.create(createProducerDto);
    return this.producersRepository.save(producer);
  }

  async getAllProducers() {
    return this.producersRepository.find({
      where: { deletedAt: IsNull(), isActive: true },
      order: { name: 'ASC' },
    });
  }

  async getProducerById(id: number) {
    const producer = await this.producersRepository.findOne({
      where: { id, deletedAt: IsNull() },
    });

    if (!producer) {
      throw new NotFoundException(`Productor con ID ${id} no encontrado`);
    }

    return producer;
  }

  async updateProducer(id: number, updateDto: Partial<Producer>) {
    const producer = await this.getProducerById(id);

    if (updateDto.rut && updateDto.rut !== producer.rut) {
      try {
        updateDto.rut = validateAndFormatRut(updateDto.rut);
      } catch (error) {
        throw new BadRequestException(error.message);
      }
    }

    Object.assign(producer, updateDto);
    return this.producersRepository.save(producer);
  }

  async addBankAccount(producerId: number, account: BankAccount) {
    const producer = await this.getProducerById(producerId);

    if (!producer.bankAccounts) {
      producer.bankAccounts = [];
    }

    producer.bankAccounts.push(account);
    return this.producersRepository.save(producer);
  }

  async removeBankAccount(producerId: number, accountIndex: number) {
    const producer = await this.getProducerById(producerId);

    if (!producer.bankAccounts || accountIndex >= producer.bankAccounts.length) {
      throw new BadRequestException('Índice de cuenta bancaria inválido');
    }

    producer.bankAccounts.splice(accountIndex, 1);
    return this.producersRepository.save(producer);
  }

  async deleteProducer(id: number) {
    await this.getProducerById(id);
    await this.producersRepository.softDelete(id);
    return { message: 'Productor eliminado' };
  }
}

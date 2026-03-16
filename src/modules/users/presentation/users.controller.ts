import {
  Controller,
  Get,
  Post,
  Put,
  Patch,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Logger,
} from '@nestjs/common';
import { UsersService } from '../application/users.service';
import { JwtAuthGuard } from '@shared/guards/jwt-auth.guard';
import { RolesGuard } from '@shared/guards/roles.guard';
import { Roles } from '@shared/decorators/roles.decorator';
import { RoleEnum } from '@shared/enums';

/**
 * Users Controller
 * Endpoints privados para gestión de usuarios del sistema
 * Requieren JWT token y rol ADMIN
 */
@Controller('users')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(RoleEnum.ADMIN)
export class UsersController {
  private logger = new Logger('UsersController');

  constructor(private usersService: UsersService) {}

  @Get()
  async getAllUsers(@Query('search') search?: string) {
    if (search && search.trim()) {
      this.logger.log(`🔍 Searching users with: "${search}"`);
    } else {
      this.logger.log('📋 Fetching all users');
    }
    const users = await this.usersService.getAllUsers(search);
    this.logger.log(`✅ Found ${users.length} users`);
    return users;
  }

  @Post()
  async createUser(
    @Body() createDto: { email: string; password: string; role: string; name: string },
  ) {
    this.logger.log(`Creating user: ${createDto.email}`);
    return this.usersService.createUser(
      createDto.email,
      createDto.password,
      createDto.role as RoleEnum,
      createDto.name,
    );
  }

  @Get(':id')
  async getUserById(@Param('id') id: number) {
    this.logger.log(`Fetching user: ${id}`);
    return this.usersService.getUserById(id);
  }

  @Patch(':id')
  async updateUser(
    @Param('id') id: number,
    @Body() updateDto: any,
  ) {
    this.logger.log(`Updating user: ${id}`);
    return this.usersService.updateUser(id, updateDto);
  }

  @Delete(':id')
  async deleteUser(@Param('id') id: number) {
    this.logger.log(`Deleting user: ${id}`);
    return this.usersService.deleteUser(id);
  }

  @Put(':id/toggle-active')
  async toggleUserActive(@Param('id') id: number) {
    this.logger.log(`Toggling active status for user: ${id}`);
    return this.usersService.toggleUserActive(id);
  }
}

import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersService } from './application/users.service';
import { PermissionsService } from './application/permissions.service';
import { UsersController } from './presentation/users.controller';
import { User } from './domain/user.entity';
import { UserPermissionOverride } from './domain/user-permission-override.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User, UserPermissionOverride])],
  providers: [UsersService, PermissionsService],
  controllers: [UsersController],
  exports: [UsersService, PermissionsService],
})
export class UsersModule {}

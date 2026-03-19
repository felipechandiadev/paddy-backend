import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthService } from './application/auth.service';
import { AuthController } from './presentation/auth.controller';
import { JwtStrategy } from './domain/jwt.strategy';
import { User } from '@modules/users/domain/user.entity';
import { UserPermissionOverride } from '@modules/users/domain/user-permission-override.entity';
import { PermissionsService } from '@modules/users/application/permissions.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, UserPermissionOverride]),
    PassportModule.register({ defaultStrategy: 'jwt' }),
    JwtModule.register({
      secret: process.env.JWT_SECRET || 'your_secret_change_in_production',
      signOptions: {
        expiresIn: process.env.JWT_EXPIRATION || '12h',
      },
    }),
  ],
  providers: [AuthService, JwtStrategy, PermissionsService],
  controllers: [AuthController],
  exports: [AuthService, JwtModule, PassportModule],
})
export class AuthModule {}

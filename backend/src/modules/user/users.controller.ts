import {
  Body,
  Controller,
  Post,
  UsePipes,
  ValidationPipe,
  Get,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { RegisterUserDto } from './dto/RegisterUser.dto';
import { LoginUserDto } from './dto/LoginUser.dto';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}
  @UsePipes(new ValidationPipe())
  @Post('register')
  async register(
    @Body() createUserDto: RegisterUserDto,
  ): Promise<{ token: String }> {
    return this.usersService.createUser(createUserDto);
  }
  @UsePipes(new ValidationPipe())
  @Post('login')
  async login(
    @Body() loginUserDto: LoginUserDto,
  ): Promise<{ token?: String; success: boolean }> {
    return this.usersService.loginUser(loginUserDto);
  }
}

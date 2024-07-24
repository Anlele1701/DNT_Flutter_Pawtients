import {
  Body,
  Controller,
  Post,
  UsePipes,
  ValidationPipe,
  Get,
  Put,
  Param,
  UseGuards,
  Request,
  NotFoundException,
  Patch,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { RegisterUserDto } from './dto/RegisterUser.dto';
import { LoginUserDto } from './dto/LoginUser.dto';
import { AuthGuard } from '../auth.guard';
import mongoose from 'mongoose';
import { FileInterceptor } from '@nestjs/platform-express';
import { UpdateUserDto } from './dto/UpdateUser.dto';
@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}
  @UsePipes(new ValidationPipe())
  @Post('register')
  async register(
    @Body() createUserDto: RegisterUserDto,
  ): Promise<{ token: String; success: boolean }> {
    return this.usersService.createUser(createUserDto);
  }
  @UsePipes(new ValidationPipe())
  @Post('login')
  async login(
    @Body() loginUserDto: LoginUserDto,
  ): Promise<{ token?: String; success: boolean }> {
    return this.usersService.loginUser(loginUserDto);
  }
  @UseGuards(AuthGuard)
  @Get('getUser')
  async getUser(@Request() req) {
    const userID = req.user.payload.id;
    console.log(userID);
    if (!mongoose.Types.ObjectId.isValid(userID)) {
      throw new NotFoundException('Invalid user ID');
    }
    const user = await this.usersService.findByID(userID);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }
  @Patch('updateUser/:id')
  @UseInterceptors(FileInterceptor('hinhAnh'))
  async updateUser(
    @Param('id') id: string,
    @UploadedFile() file: Express.Multer.File,
    @Body() updateUserDTO: UpdateUserDto,
  ) {
    mongoose.Types.ObjectId.isValid(id);
    return this.usersService.updateUser(file, updateUserDTO, id);
  }

  @Get('getUser/:id')
  async getUserByID(@Param('id') id: string): Promise<{}> {
    mongoose.Types.ObjectId.isValid(id);
    return this.usersService.findByID(id);
  }
  @Post('sendMail')
  sendMail(@Body('email') email: string) {
    return this.usersService.sendMail(email);
  }
  @Post('verifyPinCode')
  verifyPinCode(
    @Body('email') email: string,
    @Body('pinCode') pinCode: string,
  ) {
    return this.usersService.verifyPinCode(email, pinCode);
  }
  @Patch('updatePassword')
  updatePassword(
    @Body('email') email: string,
    @Body('password') password: string,
  ) {
    return this.usersService.updatePassword(email, password);
  }
}

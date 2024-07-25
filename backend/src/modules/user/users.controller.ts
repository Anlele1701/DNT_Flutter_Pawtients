import { Types } from 'mongoose';
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
import { User } from 'src/schemas/User.schema';
import { FileInterceptor } from '@nestjs/platform-express';
import { UpdateUserDto } from './dto/UpdateUser.dto';
import { ApiBadRequestResponse, ApiBasicAuth, ApiCreatedResponse, ApiNoContentResponse, ApiNotFoundResponse, ApiTags, ApiUnauthorizedResponse } from '@nestjs/swagger';
@ApiTags("USER")
@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}
  @UsePipes(new ValidationPipe())
  @Post('register')
  @ApiCreatedResponse({
    description:"Tạo object user đẻ response lại.",
    type: User
  })
  @ApiBadRequestResponse({
    description:"Tài khoản không thể tạo vui lòng thử lại."
  })
  async register(
    @Body() createUserDto: RegisterUserDto,
  ): Promise<{ token: String; success: boolean }> {
    return this.usersService.createUser(createUserDto);
  }
  @UsePipes(new ValidationPipe())

  @ApiNotFoundResponse({
    description:"Tài khoản không tồn tại."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền."
  })
  @ApiBadRequestResponse({
    description:"Hiện tại không thể đăng nhập được vui lòng thử lại sau."
  })
  @Post('login')
  async login(
    @Body() loginUserDto: LoginUserDto,
  ): Promise<{ token?: String; success: boolean }> {
    return this.usersService.loginUser(loginUserDto);
  }

  @ApiNotFoundResponse({
    description:"Không tìm thấy api này."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền để thực hiện chức năng."
  })
  @ApiBadRequestResponse({
    description:"Lỗi yêu cầu."
  })
  @ApiNoContentResponse({
    description:"Không hề có dữ liệu nào về user"
  })
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

  @ApiNotFoundResponse({
    description:"Không tìm thấy api này."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền để thực hiện chức năng."
  })
  @ApiBadRequestResponse({
    description:"Lỗi yêu cầu."
  })
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

  @ApiNotFoundResponse({
    description:"Không tìm thấy api này."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền để thực hiện chức năng."
  })
  @ApiBadRequestResponse({
    description:"Lỗi yêu cầu."
  })
  @Post('sendMail')
  sendMail(@Body('email') email: string) {
    return this.usersService.sendMail(email);
  }
  @ApiNotFoundResponse({
    description:"Không tìm thấy api này."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền để thực hiện chức năng."
  })
  @ApiBadRequestResponse({
    description:"Lỗi yêu cầu."
  })
  @Post('verifyPinCode')
  verifyPinCode(
    @Body('email') email: string,
    @Body('pinCode') pinCode: string,
  ) {
    return this.usersService.verifyPinCode(email, pinCode);
  }
  @ApiNotFoundResponse({
    description:"Không tìm thấy api này."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền để thực hiện chức năng."
  })
  @ApiBadRequestResponse({
    description:"Lỗi yêu cầu."
  })
  @Patch('updatePassword')
  updatePassword(
    @Body('email') email: string,
    @Body('password') password: string,
  ) {
    return this.usersService.updatePassword(email, password);
  }
  @ApiNotFoundResponse({
    description:"Không tìm thấy api này."
  })
  @ApiUnauthorizedResponse({
    description:"Tài khoản không được cấp quyền để thực hiện chức năng."
  })
  @ApiBadRequestResponse({
    description:"Lỗi yêu cầu."
  })
  @Get('/get-user-list')
  async getUserList():Promise<User[]>{
    return await this.usersService.getUserList();
  }
}

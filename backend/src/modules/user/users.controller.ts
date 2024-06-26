import { Body, Controller, Post, UsePipes, ValidationPipe , Get} from "@nestjs/common";
import { UsersService } from "./users.service";
import { RegisterUserDto } from "./dto/RegisterUser.dto";
import { User } from "src/schemas/User.schema";
import * as bcrypt from 'bcrypt';
import { LoginUserDto } from "./dto/LoginUser.dto";

@Controller('users')
export class UsersController{
    constructor(private usersService: UsersService){}
    @UsePipes(new ValidationPipe())
    @Post('register')
    async register(@Body() createUserDto: RegisterUserDto): Promise<{token: String}> {
      return this.usersService.createUser(createUserDto);
    }
    @UsePipes(new ValidationPipe())
    @Get('login')
    async login(@Body() loginUserDto: LoginUserDto): Promise<{token: String}> {
        return this.usersService.loginUser(loginUserDto);
    }
}
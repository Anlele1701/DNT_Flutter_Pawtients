import { Body, Controller, Post, UsePipes, ValidationPipe } from "@nestjs/common";
import { UsersService } from "./users.service";
import { CreateUserDto } from "./dto/CreateUser.dto";
import { User } from "src/schemas/User.schema";

@Controller('users')
export class UsersController{
    constructor(private usersService: UsersService){}
    @Post()
    @UsePipes(new ValidationPipe())
    createUser(@Body() createUserDto: CreateUserDto):Promise<User>{
        return this.usersService.createUser(createUserDto);
    }
}
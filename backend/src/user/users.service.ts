import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/schemas/User.schema';
import { CreateUserDto } from './dto/CreateUser.dto';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private userModel: Model<User>) {}

 async createUser(createUserDto: CreateUserDto) : Promise<User>{
    const newUser = new this.userModel(createUserDto);
    return await newUser.save();
  }
}

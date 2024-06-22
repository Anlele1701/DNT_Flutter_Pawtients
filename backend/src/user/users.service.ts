import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/schemas/User.schema';
import { RegisterUserDto } from './dto/RegisterUser.dto';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private userModel: Model<User>) {}

 async createUser(createUserDto: RegisterUserDto) : Promise<User>{
    const newUser = new this.userModel(createUserDto);
    return await newUser.save();
  }
}

import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/schemas/User.schema';
import { RegisterUserDto } from './dto/RegisterUser.dto';
import { LoginUserDto } from './dto/LoginUser.dto';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    private jwtService: JwtService,
  ) {}

  async createUser(createUserDto: RegisterUserDto): Promise<{ token: String }> {
    const hashedPassword = await bcrypt.hash(createUserDto.password, 12);
    const newUser = await this.userModel.create({
      ...createUserDto,
      password: hashedPassword,
    });
    const token = this.jwtService.sign({ id: newUser._id });
    return { token };
  }
  async loginUser(loginUserDto: LoginUserDto): Promise<{ token: String }> {
    const user = await this.userModel.findOne({
      email: loginUserDto.email,
    });
    if (!user) {
      throw new Error('User not found');
    }
    const passwordMatched = await bcrypt.compare(
      loginUserDto.password,
      user.password,
    );
    if (!passwordMatched) {
      throw new Error('Password not matched');
    }
    const token = this.jwtService.sign({ id: user._id });
    return { token };
  }
}

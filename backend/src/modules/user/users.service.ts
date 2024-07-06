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

  async createUser(
    createUserDto: RegisterUserDto,
  ): Promise<{ token: String; success: boolean }> {
    const hashedPassword = await bcrypt.hash(createUserDto.password, 12);
    const newUser = await this.userModel.create({
      ...createUserDto,
      password: hashedPassword,
    });
    const token = this.jwtService.sign({ id: newUser._id });
    return { token, success: true };
  }
  async loginUser(
    loginUserDto: LoginUserDto,
  ): Promise<{ token?: String; success: boolean }> {
    const user = await this.userModel.findOne({
      email: loginUserDto.email,
    });
    if (!user) {
      return { success: false };
    }
    const passwordMatched = await bcrypt.compare(
      loginUserDto.password,
      user.password,
    );
    if (!passwordMatched) {
      return { success: false };
    }
    const payload = { id: user._id };
    const token = await this.jwtService.signAsync({ payload });
    return { success: true, token: token };
  }
  async findById(id: string) {
    return this.userModel.findById(id);
  }
  // async findByID(id: String): Promise<{}> {
  //   return this.userModel.findById(id);
  // }
}

import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/schemas/User.schema';
import { RegisterUserDto } from './dto/RegisterUser.dto';
import { LoginUserDto } from './dto/LoginUser.dto';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { Image } from 'src/schemas/Image';
import { MailerService } from '@nestjs-modules/mailer';
import { UpdateUserDto } from './dto/UpdateUser.dto';
@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    private jwtService: JwtService,
    private readonly mailerService: MailerService,
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
  async updateUser(
    image: Express.Multer.File,
    updateUserDTO: UpdateUserDto,
    id: String,
  ): Promise<{}> {
    if (image) {
      const hinhAnh = new Image(
        image.originalname,
        image.buffer,
        image.mimetype,
      );
      return this.userModel.findByIdAndUpdate(
        { ...updateUserDTO, hinhAnh: hinhAnh },
        id,
      );
    } else {
      return this.userModel.findByIdAndUpdate(updateUserDTO, id);
    }
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
  async findByID(id: String): Promise<{}> {
    return this.userModel.findById(id);
  }
  async sendMail(
    email: string,
  ): Promise<{ success: boolean; message: string }> {
    const user = await this.userModel.findOne({ email: email });
    if (user) {
      const pinCode = Math.floor(Math.random() * 10000)
        .toString()
        .padStart(4, '0');
      user.pinCode = pinCode;
      await user.save();
      await this.mailerService.sendMail({
        to: email,
        subject: 'Pawtients Pincode Verification',
        html: `
       <p> Xin chào  ${user.hoTen}, </p>
       Vui lòng nhập mã pincode này để xác thực email và reset mật khẩu: ${pinCode}
      `,
      });
      return { success: true, message: 'Đã gửi link làm lại mật khẩu' };
    } else {
      return { success: false, message: 'Không tìm thấy người dùng' };
    }
  }
  async verifyPinCode(
    email: string,
    pinCode: string,
  ): Promise<{ success: boolean; message: string }> {
    const user = await this.userModel.findOne({ email: email });
    if (user.pinCode === pinCode) {
      return { success: true, message: 'Xác thực thành công' };
    } else {
      return { success: false, message: 'Xác thực thất bại' };
    }
  }
  async updatePassword(
    email: string,
    password: string,
  ): Promise<{ success: boolean; message: string }> {
    const user = await this.userModel.findOne({ email: email });
    const hashedPassword = await bcrypt.hash(password, 12);
    user.password = hashedPassword;
    await user.save();
    return { success: true, message: 'Cập nhật mật khẩu thành công' };
  }
}

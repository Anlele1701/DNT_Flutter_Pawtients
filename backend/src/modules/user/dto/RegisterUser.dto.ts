import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class RegisterUserDto {
  @IsNotEmpty()
  @IsString({ message: 'Họ tên phải là chuỗi' })
  hoTen: string;
  @IsNotEmpty()
  sdt: string;
  @IsNotEmpty()
  password: string;
  @IsEmail({}, {message: 'Email không hợp lệ'})
  @IsNotEmpty()
  email: string;
}

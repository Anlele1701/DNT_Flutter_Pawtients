import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class RegisterUserDto {
  @ApiProperty({
    description: "Họ và tên",
    example:"Trương Quang Huy"
  })
  @IsNotEmpty()
  @IsString({ message: 'Họ tên phải là chuỗi' })
  hoTen: string;

  @ApiProperty({
    description: "Số điện thoại",
    example:"0987654321"
  })
  @IsNotEmpty()
  sdt: string;

  @ApiProperty({
    description: "Mật khẩu",
    example:"sjdhaksd281391"
  })
  @IsNotEmpty()
  password: string;

  @ApiProperty({
    description: "Email",
    example:"example@gmail.com"
  })
  @IsEmail({}, {message: 'Email không hợp lệ'})
  @IsNotEmpty()
  email: string;
}

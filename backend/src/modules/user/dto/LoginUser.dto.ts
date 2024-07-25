import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty } from 'class-validator';

export class LoginUserDto {
  @ApiProperty({
    example:"example@gmail.com"
  })
  @IsEmail()
  @IsNotEmpty({ message: 'Email không được để trống' })
  email: string;
  @ApiProperty({
    example:"sadfjsfdjwioei!ASS"
  })
  @IsNotEmpty({ message: 'Mật khẩu không được để trống' })
  password: string;
}

import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty } from 'class-validator';

export class LoginEmployeeDto {
  @ApiProperty({
    example:"NV01"
  })
  @IsNotEmpty({ message: 'Email không được để trống' })
  tenTK: string;
  @ApiProperty({
    example:"03032003"
  })
  @IsNotEmpty({ message: 'Mật khẩu không được để trống' })
  matKhau: string;
}

import { IsEmail, IsNotEmpty } from 'class-validator';

export class LoginEmployeeDto {
  @IsNotEmpty({ message: 'Email không được để trống' })
  tenTK: string;
  @IsNotEmpty({ message: 'Mật khẩu không được để trống' })
  matKhau: string;
}

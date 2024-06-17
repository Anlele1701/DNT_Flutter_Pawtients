import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class CreateUserDto {
  @IsNotEmpty()
  @IsString()
  hoTen: string;
  @IsNotEmpty()
  sdt: string;
  @IsNotEmpty()
  password: string;
  @IsEmail()
  @IsNotEmpty()
  email: string;
}

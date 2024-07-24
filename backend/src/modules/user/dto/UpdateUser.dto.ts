import { Image } from 'src/schemas/Image';

export class UpdateUserDto {
  hoTen: string;
  sdt: string;
  password: string;
  email: string;
  hinhAnh: Image;
}

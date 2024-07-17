import { Image } from 'src/schemas/Image';
export class CreateEmployeeDTO {
  hoTen: string;
  sdt: string;
  gioiTinh: boolean;
  hinhAnh: Image;
  tenTK: string;
  matKhau: string;
  chucVu: string;
}

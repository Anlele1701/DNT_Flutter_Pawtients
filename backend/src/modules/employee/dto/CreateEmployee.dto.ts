import { ApiProperty } from '@nestjs/swagger';
import { Image } from 'src/schemas/Image';
export class CreateEmployeeDTO {
  @ApiProperty({
    example:"Trương Quang Huy"
  })
  hoTen: string;
  @ApiProperty({
    example:"0987654321"
  })
  sdt: string;
  @ApiProperty({
    example:"true"
  })
  gioiTinh: boolean;
  @ApiProperty({
    example:"hinhchandung.png"
  })
  hinhAnh: Image;
  @ApiProperty({
    example:"NV01"
  })
  tenTK: string;
  @ApiProperty({
    example:"03032003"
  })
  matKhau: string;
  @ApiProperty({
    example:"Bác sỉ"
  })
  chucVu: string;
}

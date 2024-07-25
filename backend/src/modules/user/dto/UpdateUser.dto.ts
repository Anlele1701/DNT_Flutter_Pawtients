import { ApiProperty } from '@nestjs/swagger';
import { Image } from 'src/schemas/Image';

export class UpdateUserDto {
  @ApiProperty({
    example:"Trương Quang Huy"
  })
  hoTen: string;
  @ApiProperty({
    example:"0987654321"
  })
  sdt: string;
  @ApiProperty({
    example:"kjsdfwuhefow@Ass23!"
  })
  password: string;
  @ApiProperty({
    example:"example@gmail.com"
  })
  email: string;
  @ApiProperty({
    example:"hinhchandung.jpg"
  })
  hinhAnh: Image;
}

import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ApiProperty } from '@nestjs/swagger';
import { Image } from 'src/schemas/Image';

@Schema()
export class User {
  @ApiProperty({
    example:"Trương Quang Huy"
  })
  @Prop({ required: true, trim: true })
  hoTen: string;
  @ApiProperty({
    example:"0987654321"
  })
  @Prop({ required: true })
  sdt: string;
  @ApiProperty({
    example:"jksfdnksdf@132314saA"
  })
  @Prop({
    required: true,
    trim: true,
    minlength: 8,
    validate(value) {
      if (!value.match(/\d/) || !value.match(/[a-zA-Z]/)) {
        throw new Error(
          'Password must contain at least one letter and one number',
        );
      }
    },
  })
  password: string;
  @Prop({ required: true, trim: true, lowercase: true, unique: true })
  @ApiProperty({
    example:"Example@gmail.com"
  })
  email: string;
  @Prop({ required: false })
  gender: boolean;
  @Prop({ default: 0 })
  diem: number;
  @Prop({ required: false })
  diaChi: string;
  @Prop({ required: false, default: 'Mèo con' })
  hangThanhVien: string;
  @Prop({ required: false })
  pinCode: string;
  @Prop({ type: [String] })
  dsThuCung: string[];
  @Prop({ type: [String] })
  dsLichKham: string[];
  @Prop({ required: false, trim: true })
  hinhAnh: Image;
}
export const UserSchema = SchemaFactory.createForClass(User);

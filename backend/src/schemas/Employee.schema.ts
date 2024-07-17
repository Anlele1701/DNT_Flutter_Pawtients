import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Image } from './Image';

@Schema()
export class Employee {
  @Prop({ required: true, trim: true })
  hoTen: String;
  @Prop({ required: true, trim: true })
  sdt: String;
  @Prop({ required: true })
  gioiTinh: boolean;
  @Prop({ required: false, trim: true })
  hinhAnh: Image;
  @Prop({ required: true, trim: true })
  tenTK: String;
  @Prop({ required: true, trim: true })
  matKhau: String;
  @Prop({ required: true, trim: true })
  chucVu: String;
}

export const EmployeeSchema = SchemaFactory.createForClass(Employee);

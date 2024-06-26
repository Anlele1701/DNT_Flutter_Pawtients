import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';

@Schema()
export class User {
  @Prop({ required: true, trim: true })
  hoTen: string;
  @Prop({ required: true })
  sdt: string;
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
  email: string;
  @Prop({ required: false })
  gender: boolean;
  @Prop({ default: 0 })
  diem: number;
  @Prop({ required: false })
  diaChi: string;
  @Prop({ required: false, default: 'Mèo con' })
  hangThanhVien: string;
  @Prop({ type: [String] })
  dsThuCung: string[];
}
export const UserSchema = SchemaFactory.createForClass(User);

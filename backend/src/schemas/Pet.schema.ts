import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Image } from "./Image";
import { Appointment } from "./Appointment.schema";
import mongoose, { Types } from "mongoose";

@Schema()
export class Pet{
    @Prop({required: true, trim: true})
    tenThuCung: String;
    @Prop({required: false, type: Date})
    ngaySinh: Date;
    @Prop({required: true, trim: true})
    loaiThuCung: String;
    @Prop({required: true, trim: true})
    giongLoai: String;
    @Prop({required: false, type: Boolean})
    gioiTinh: boolean;
    @Prop({required: false, trim: true})
    canNang: String;
    @Prop({required: false, type: Image})
    hinhAnh: Image;
    @Prop({ type: [{ type: Types.ObjectId, ref: 'appointment' }] })
    dsLichKham: Types.ObjectId[];
}
export const PetSchema=SchemaFactory.createForClass(Pet);
import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Image } from "./Image.schema";
import { Appointment } from "./Appointment.schema";
import mongoose from "mongoose";

@Schema()
export class Pet{
    @Prop({required: true, trim: true})
    tenThuCung: String;
    @Prop({required: true, type: Date})
    ngaySinh: Date;
    @Prop({required: true, trim: true})
    soThich: String;
    @Prop({required: true, trim: true})
    giongLoai: String;
    @Prop({required: true, type: Boolean})
    gioiTinh: boolean;
    @Prop({required: true, trim: true})
    tinhTrangBenh: String;
    @Prop({required: true, type: [Image]})
    hinhAnh: [Image];
    @Prop({required: true, type: [{type: mongoose.Schema.Types.ObjectId, ref:'Appointment'}]})
    dsLichKham: [Appointment]
}
export const PetSchema=SchemaFactory.createForClass(Pet);
import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { PetService } from "./PetService.schema";
import mongoose, { Document, mongo, Types } from "mongoose";
import { Bill } from "./Bill.schema";
import { Pet } from "./Pet.schema";

@Schema()
export class Appointment extends Document{
    @Prop({type: Date})
    ngayKham: Date;
    @Prop({type: String })
    loaiDichVu: String;
    @Prop({trim: true})
    tinhTrangBenh: String;
    @Prop({default: 'Chưa xác nhận'})
    trangThai: String;
    @Prop({type: String })
    idNV: String;
    @Prop({type: String })
    idHoaDon: String;
    @Prop({type: String })
    idThuCung: String;
    @Prop({required: true, default: false})
    thongBao: boolean;
}

export const AppointmentSchema= SchemaFactory.createForClass(Appointment);
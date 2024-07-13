import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { PetService } from "./PetService.schema";
import mongoose, { mongo } from "mongoose";
import { Bill } from "./Bill.schema";
import { Pet } from "./Pet.schema";

@Schema()
export class Appointment{
    @Prop({type: Date, required: true})
    ngayKham: Date;
    @Prop({type: String})
    loaiDichVu: String;
    @Prop({trim: true})
    tinhTrangBenh: String;
    @Prop({default: 'Chưa xác nhận'})
    trangThai: String;
    @Prop({type: String})
    idNV: String;
    @Prop({type: String})
    idHoaDon: String;
    @Prop({type: String})
    idThuCung: String;
    @Prop({required: true, default: false})
    thongBao: boolean;
}

export const AppointmentSchema= SchemaFactory.createForClass(Appointment);
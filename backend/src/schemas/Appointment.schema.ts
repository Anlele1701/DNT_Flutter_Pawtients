import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { PetService } from "./PetService.schema";
import mongoose, { mongo } from "mongoose";
import { Bill } from "./Bill.schema";
import { Pet } from "./Pet.schema";

@Schema()
export class Appointment{
    @Prop({type: Date, required: true})
    ngayKham: Date;
    @Prop({type: mongoose.Schema.Types.ObjectId, ref: 'PetService'})
    loaiDichVu: PetService;
    @Prop({trim: true})
    tinhTrangBenh: String;
    @Prop({default: 'Chưa xác nhận'})
    trangThai: String;
    @Prop({type: mongoose.Schema.Types.ObjectId, ref: 'Employee'})
    idNV: String;
    @Prop({type: mongoose.Schema.Types.ObjectId, ref: 'Bill'})
    idHoaDon: Bill;
    @Prop({type: mongoose.Schema.Types.ObjectId, ref: 'Pet'})
    idThuCung: Pet;
    @Prop({required: true, default: false})
    thongBao: boolean;
}

export const AppointmentSchema= SchemaFactory.createForClass(Appointment);
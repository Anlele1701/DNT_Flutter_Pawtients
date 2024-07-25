import { Prop, Schema, SchemaFactory, raw } from "@nestjs/mongoose";
import { Vacxin } from "./Vacxin.schema";
import { Drug } from "./Drug.schema";
import mongoose from "mongoose";
import { Image } from "./Image";
import { PetService } from "./PetService.schema";
import { Appointment } from "./Appointment.schema";
import { Order } from "./Order";

@Schema()
export class Bill{
    @Prop({trim: true})
    chanDoan: String;
    @Prop({type: [Order]})
    keDonThuoc: Order[];
    @Prop({type: String})
    phiDichVu: String;
    @Prop({type: [Image]})
    hinhAnh: Image[];
    @Prop({default: 0})
    tongTien: number;
    @Prop({type: String})
    idLichKham: String;
    @Prop({type: String})
    tenThuCung: String;
    @Prop({type: String})
    tenDichVu: String;
    @Prop({type: Date})
    ngayKham: Date;
}

export const BillSchema= SchemaFactory.createForClass(Bill);
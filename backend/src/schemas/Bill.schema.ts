import { Prop, Schema, SchemaFactory, raw } from "@nestjs/mongoose";
import { Vacxin } from "./Vacxin.schema";
import { Drug } from "./Drug.schema";
import mongoose from "mongoose";
import { Image } from "./Image";
import { PetService } from "./PetService.schema";
import { Appointment } from "./Appointment.schema";

@Schema()
export class Bill{
    @Prop({trim: true})
    chanDoan: String;
    @Prop([raw({
        idThuoc: {type: mongoose.Schema.Types.ObjectId},
        soLuong: {type: mongoose.Schema.Types.Number, default: 1},
        thanhTien: {type: mongoose.Schema.Types.Number, default: 0}
    })])
    @Prop({type: mongoose.Schema.Types.ObjectId, ref: 'PetService'})
    phiDichVu: PetService;
    keDonThuoc: [
        {
            idThuoc: Vacxin | Drug;
            soLuong: number;
            thanhTien: number;
        }
    ];
    @Prop({type: Image})
    hinhAnh: [Image]
    @Prop({default: 0})
    tongTien: number;
    @Prop({type: mongoose.Schema.Types.ObjectId, ref: 'Appointment'})
    idLichKham: Appointment;
}

export const BillSchema= SchemaFactory.createForClass(Bill);
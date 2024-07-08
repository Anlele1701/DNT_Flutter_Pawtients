import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Image } from "./Image";

@Schema()
export class Vacxin{
    @Prop({required: true, trim:true})
    tenVacxin: String;
    @Prop({required: true, trim:true})
    phongBenh:String;
    @Prop({required: true, trim:true})
    hangVacxin: String;
    @Prop({required: true, trim: true})
    moTa: String;
    @Prop({required: true, trim: true})
    thanhPhan: String;
    @Prop({required: true, default:0})
    giaTien: number;
    @Prop({required: true, trim: true})
    quocGia: String;
    @Prop({type: Image, required:true})
    hinhAnh: Image;
}

export const VacxinSchema = SchemaFactory.createForClass(Vacxin);
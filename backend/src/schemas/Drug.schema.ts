import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Image } from "./Image";

@Schema()
export class Drug{
    @Prop({required: true, trim: true})
    tenThuoc: String;
    @Prop({required: true, trim: true})
    hangThuoc: String;
    @Prop({required: false, trim: true})
    moTa: String;
    @Prop({required: false, trim: true})
    soLuong: number;
    @Prop({required: true, default: 0})
    giaTien: number;
    @Prop({required: true, trim: true})
    phongBenh: String;
    @Prop({type:Image,})
    hinhAnh: Image;
}

export const DrugSchema=SchemaFactory.createForClass(Drug);
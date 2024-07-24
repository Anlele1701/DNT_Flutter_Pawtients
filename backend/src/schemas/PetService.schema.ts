import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema()
export class PetService extends Document{
    @Prop({required: true, trim: true})
    tenDichVu: String;
    @Prop({required: true, trim: true})
    moTa: String;
    @Prop({required: true})
    giaTien: number;
}

export const PetServiceSchema= SchemaFactory.createForClass(PetService)
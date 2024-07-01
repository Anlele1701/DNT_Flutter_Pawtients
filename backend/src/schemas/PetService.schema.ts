import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";

@Schema()
export class PetService{
    @Prop({required: true, trim: true})
    tenDichVu: String;
    @Prop({required: true, trim: true})
    moTa: String;
    @Prop({required: true})
    giaTien: number;
}

export const PetServiceSchema= SchemaFactory.createForClass(PetService)
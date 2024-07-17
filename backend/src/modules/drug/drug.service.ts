import { Injectable } from "@nestjs/common";
import { Drug } from "src/schemas/Drug.schema";
import { Image } from "src/schemas/Image";
import { CreateDrugDto } from "./dto/create_new_drug.dto";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";

@Injectable()
export class DrugService{
    constructor(@InjectModel(Drug.name) private drugModel: Model<Drug>){}
    async createNewDrug(image: Express.Multer.File, createDrugDto: CreateDrugDto):Promise<Drug>{
        try{
            const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
            createDrugDto.hinhAnh=hinhAnh;
            const newDrug= new this.drugModel(createDrugDto);
            await newDrug.save();
            if(newDrug){
                return newDrug;
            }
            else return null;
        }
        catch(e){
            console.log(e);
            return e;
        }
    }

    async getDrugList(): Promise<Drug[]>{
        try{
            const drugList= await this.drugModel.find();
            return drugList;
        }catch(e){
            console.log(e);
            return e;
        }
    }
}
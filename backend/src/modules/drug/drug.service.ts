import { Injectable } from "@nestjs/common";
import { Drug } from "src/schemas/Drug.schema";
import { Image } from "src/schemas/Image";
import { CreateDrugDto } from "./dto/create_new_drug.dto";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { UpdateDrugDto } from "./dto/update_drug.dto";

@Injectable()
export class DrugService{
    constructor(@InjectModel(Drug.name) private drugModel: Model<Drug>){}
    async createNewDrug(image: Express.Multer.File, createDrugDto: CreateDrugDto):Promise<Drug>{
        try{
            const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
            createDrugDto.hinhAnh=hinhAnh;
            const newDrug= new this.drugModel(createDrugDto);
            await newDrug.save();
            console.log(newDrug);
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

    async getDrugList(skip: number, limit: number): Promise<Drug[]>{
        try{
            const drugList= await this.drugModel.find().skip(skip).limit(limit);
            console.log(skip);
            console.log(limit);
            return drugList;
        }catch(e){
            console.log(e);
            return e;
        }
    }

    async searchDrugList(skip: number, limit: number, search: string): Promise<Drug[]>{
        try{
            const regex = new RegExp(search, 'i');
            const drugList= await this.drugModel.find({tenThuoc:{$regex: regex}}).skip(skip).limit(limit);
            console.log(skip);
            console.log(limit);
            return drugList;
        }catch(e){
            console.log(e);
            return e;
        }
    }
    async updateDrug(image: Express.Multer.File, updateDrugDto: UpdateDrugDto):Promise<Drug>{
        try{
            console.log(updateDrugDto.id);
            const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
            updateDrugDto.hinhAnh=hinhAnh;
            const drug= await this.drugModel.findOne({_id:updateDrugDto.id});
            console.log(drug);
            if(!drug) return null;
            else{
                Object.assign(drug, updateDrugDto);
                await drug.save();
                console.log(drug);
                return drug;
            }
        }
        catch(e){
            console.log(e);
            return e;
        }
    }
}
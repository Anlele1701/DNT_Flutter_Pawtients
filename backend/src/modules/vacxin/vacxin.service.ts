import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Vacxin } from "src/schemas/Vacxin.schema";
import { CreateNewVacxinDto } from "./dto/create_new_vacxin.dto";
import { Image } from "src/schemas/Image";

@Injectable()
export class VacxinService{
    constructor(@InjectModel(Vacxin.name) private vacxinModel: Model<Vacxin>){}
    async createNewVacxin(image: Express.Multer.File, createVacxinDto: CreateNewVacxinDto):Promise<Vacxin>{
        try{
            const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
            createVacxinDto.hinhAnh=hinhAnh;
            const newVacxin= new this.vacxinModel(createVacxinDto);
            await newVacxin.save();
            console.log(newVacxin);
            if(newVacxin){
                return newVacxin;
            }
            else return null;
        }
        catch(e){
            console.log(e);
            return e;
        }
    }

    async getVacxinList(skip: number, limit: number){
        try{
            const vacxinList= await this.vacxinModel.find().skip(skip).limit(limit);
            return vacxinList;
        }catch(e){
            console.log(e);
            return e;
        }
    }
}
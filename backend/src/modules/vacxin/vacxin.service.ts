import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Vacxin } from "src/schemas/Vacxin.schema";
import { CreateNewVacxinDto } from "./dto/create_new_vacxin.dto";
import { Image } from "src/schemas/Image";
import { UpdateVacxinDto } from "./dto/update_vacxin.dto";

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

    async searchVacxinList(skip: number, limit: number, search: string){
        try{
            const regex=new RegExp(search, 'i');
            const vacxinList= await this.vacxinModel.find({tenVacxin: {$regex: regex}}).skip(skip).limit(limit);
            return vacxinList;
        }catch(e){
            console.log(e);
            return e;
        }
    }

    async updateVacxin(image: Express.Multer.File, updateVacxinDto: UpdateVacxinDto):Promise<Vacxin>{
        try{
            const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
            updateVacxinDto.hinhAnh=hinhAnh;
            const vacxin= await this.vacxinModel.findById(updateVacxinDto.id);
            if(!vacxin) return null;
            else{
                Object.assign(vacxin, updateVacxinDto);
                await vacxin.save();
                console.log(vacxin);
                return vacxin;
            }
        }
        catch(e){
            console.log(e);
            return e;
        }
    }
}
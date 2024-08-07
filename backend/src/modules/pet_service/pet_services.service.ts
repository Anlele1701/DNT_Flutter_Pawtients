import { Inject, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { PetService } from "src/schemas/PetService.schema";
import { CreatePetServiceDto } from "./dto/create_pet_service.dto";

@Injectable()
export class Pet_Services_Service{
    constructor(@InjectModel(PetService.name) private petServiceModel: Model<PetService>){}
    async createNewService(createPetServiceDto: CreatePetServiceDto):Promise<PetService>{
        const newService= new this.petServiceModel(createPetServiceDto)
        return await newService.save()
    }
    async findIDPeTService(nameService: String):Promise<String>{
        try{
            const service= await this.petServiceModel.findOne({tenDichVu: nameService});
            return service.id;
        }catch(e){
            console.log(e);
            return e;
        }
    }

    async getNameService(idService: String):Promise<String>{
        try{
            const service= await this.petServiceModel.findOne({'_id':idService});
            if(service) return service.tenDichVu;
            else return '';
        }catch(e){
            console.log(e);
            return e;
        }
    }

    async getPrice(idService: String): Promise<number>{
        try{
            const service=await this.petServiceModel.findOne({'_id':idService});
            if(service) return service.giaTien;
            else return 0;
        }catch(e){
            console.log(e);
            return e;
        }
    }
}
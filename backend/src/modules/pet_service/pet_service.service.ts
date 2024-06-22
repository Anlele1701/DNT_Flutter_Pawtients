import { Inject, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { PetService } from "src/schemas/PetService.schema";
import { CreatePetServiceDto } from "./dto/create_pet_service.dto";

@Injectable()
export class Pet_S_Service{
    constructor(@InjectModel(PetService.name) private petServiceModel: Model<PetService>){}
    async createNewService(createPetServiceDto: CreatePetServiceDto):Promise<PetService>{
        const newService= new this.petServiceModel(createPetServiceDto)
        return await newService.save()
    }
}
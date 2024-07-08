import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Pet } from "src/schemas/Pet.schema";
import { CreatePetDto } from "./dto/create_pet.dto";
import { Image } from "src/schemas/Image";
import { parse } from "date-fns";

@Injectable()
export class PetService{
    constructor(@InjectModel(Pet.name) private petModel: Model<Pet>){}
    async createNewPet(image: Express.Multer.File, createNewPetDto: CreatePetDto):Promise<Pet>{
        const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
        createNewPetDto.hinhAnh=hinhAnh;
        // createNewPetDto.ngaySinh=parse(createNewPetDto.ngaySinh, 'dd/MM/yyyy', new Date());
        // if(createNewPetDto.gioiTinh=='BT') createNewPetDto.gioiTinh=true;
        // else createNewPetDto.gioiTinh=false;
        const newPet= new this.petModel(createNewPetDto)
        console.log(newPet);
        return await newPet.save();
    }
}
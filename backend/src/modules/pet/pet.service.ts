import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Pet } from "src/schemas/Pet.schema";
import { CreatePetDto } from "./dto/create_pet.dto";
import { Image } from "src/schemas/Image";
import { parse } from "date-fns";
import { User } from "src/schemas/User.schema";

@Injectable()
export class PetService{
    constructor(@InjectModel(Pet.name) private petModel: Model<Pet>, @InjectModel(User.name) private userModel: Model<User>){}
    async createNewPet(image: Express.Multer.File, createNewPetDto: CreatePetDto, userID: String):Promise<Pet>{
        try{
            console.log(userID);
            const hinhAnh=new Image(image.originalname,image.buffer,image.mimetype);
            createNewPetDto.hinhAnh=hinhAnh;
            const newPet= new this.petModel(createNewPetDto)
            await newPet.save()
            if(newPet){
                const id=newPet.id;
                const user=await this.userModel.findById(userID);
                if (!user) {
                    throw new Error('User not found');
                  }
                  user.dsThuCung.push(id);
                  await user.save();
            }
            return newPet;
        }
        catch(e){
            console.log(e);
            return e;
        }
    }

    async getPetList(userID: String): Promise<Pet[]>{
        try{
            const listPetID=(await this.userModel.findById(userID)).dsThuCung;
            const petList=await Promise.all(
                listPetID.map(async petID=>{
                    const pet=await this.petModel.findById(petID);
                    return pet;
                })
            )
            console.log(petList);
            return petList;
        }catch(e){
            console.log(e);
            return e;
        }
    }
}
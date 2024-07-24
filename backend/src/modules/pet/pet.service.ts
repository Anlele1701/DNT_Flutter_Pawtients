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

    async getPet(idThuCung: String): Promise<Pet>{
        try{
            const pet= await this.petModel.findOne({'_id': idThuCung});
            if(pet) return pet;
            else return null;
        }
        catch(e){
            console.log(e);
            return(e);
        }
    }
    async getPetListAd(dsIdThuCung: String[]): Promise<Pet[]>{
        try{
            const petList= await this.petModel.find({_id: {$in: dsIdThuCung}}).exec();
            if(petList) return petList;
        }catch(e){
            console.log(e);
            return null;
        }
    }

    async getHinhAnh(idThuCung: String):Promise<{}>{
        try{
            const pet=await this.petModel.findOne({'_id':idThuCung});
            if(pet.hinhAnh!=null){
                return {
                    'hinhAnh':pet.hinhAnh,
                    'tenThuCung':pet.tenThuCung
                };
            }
            else return null;
        }catch(e){
            console.log(e);
            return null;
        }
    }
}
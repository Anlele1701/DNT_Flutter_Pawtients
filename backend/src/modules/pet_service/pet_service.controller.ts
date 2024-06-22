import { CreatePetServiceDto } from './dto/create_pet_service.dto';
import { Body, Controller, Post, UsePipes, ValidationPipe } from "@nestjs/common";
import { Pet_S_Service } from "./pet_service.service";
import { PetService } from "src/schemas/PetService.schema";

@Controller('pet-service')
export class Pet_S_Controller{
    constructor(private readonly petService: Pet_S_Service){}
    @Post('/create-new-pet-service')
    @UsePipes(new ValidationPipe())
    CreateNewPetService(@Body() createPetServiceDto:CreatePetServiceDto):Promise<PetService>{
        return this.petService.createNewService(createPetServiceDto)
    }
}
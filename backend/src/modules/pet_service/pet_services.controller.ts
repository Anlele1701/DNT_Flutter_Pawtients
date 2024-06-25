import { CreatePetServiceDto } from './dto/create_pet_service.dto';
import { Body, Controller, Post, UsePipes, ValidationPipe } from "@nestjs/common";
import { Pet_Services_Service } from "./pet_services.service";
import { PetService } from "src/schemas/PetService.schema";

@Controller('pet-service')
export class Pet_Services_Controller{
    constructor(private readonly petService: Pet_Services_Service){}
    @Post('/create-new-pet-service')
    @UsePipes(new ValidationPipe())
    CreateNewPetService(@Body() createPetServiceDto:CreatePetServiceDto):Promise<PetService>{
        return this.petService.createNewService(createPetServiceDto)
    }
}
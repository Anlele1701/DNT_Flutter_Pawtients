import { CreatePetServiceDto } from './dto/create_pet_service.dto';
import { Body, Controller, Get, Param, Post, UsePipes, ValidationPipe } from "@nestjs/common";
import { Pet_Services_Service } from "./pet_services.service";
import { PetService } from "src/schemas/PetService.schema";
import { ApiTags } from '@nestjs/swagger';
@ApiTags("PETS_SERVICE")
@Controller('pet-service')
export class Pet_Services_Controller{
    constructor(private readonly petService: Pet_Services_Service){}
    @Post('/create-new-pet-service')
    @UsePipes(new ValidationPipe())
    CreateNewPetService(@Body() createPetServiceDto:CreatePetServiceDto):Promise<PetService>{
        return this.petService.createNewService(createPetServiceDto)
    }

    @Get('/getNameService/:id')
    async getNameService(@Param('id') idService: String):Promise<String>{
        return await this.petService.getNameService(idService);
    }

    @Get('/getPrice/:id')
    async getPrice(@Param('id') idService: String):Promise<Number>{
        return await this.petService.getPrice(idService);
    }
}
import { FileInterceptor } from '@nestjs/platform-express';
import { MulterField } from './../../../node_modules/@nestjs/platform-express/multer/interfaces/multer-options.interface.d';
import { Body, Controller, Get, Post, Query, UploadedFile, UseInterceptors, UsePipes, ValidationPipe } from "@nestjs/common";
import { CreatePetDto } from './dto/create_pet.dto';
import { Pet } from 'src/schemas/Pet.schema';
import { PetService } from './pet.service';

@Controller('pet')
export class PetController{
    constructor(private readonly petService:PetService){}
    @Post('/create-new-pet')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async createNewPet(@UploadedFile() file: Express.Multer.File, @Body('pet') createPetDto: CreatePetDto, @Body("userID") userID: String):Promise<Pet>{
        const createPet= await this.petService.createNewPet(file, createPetDto, userID);
        return createPet;
    }
    @Get('/get-pet-list')
    async getPetList(@Query('userID') userID: String): Promise<Pet[]>{
        return await this.petService.getPetList(userID);
    }
}
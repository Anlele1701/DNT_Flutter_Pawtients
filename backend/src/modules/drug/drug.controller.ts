import { Body, Controller, Get, Post, UploadedFile, UseInterceptors, UsePipes, ValidationPipe } from "@nestjs/common";
import { CreateDrugDto } from "./dto/create_new_drug.dto";
import { DrugService } from "./drug.service";
import { FileInterceptor } from "@nestjs/platform-express";

@Controller('drug')
export class DrugController{
    constructor(private readonly drugService:DrugService){}
    @Post('/create-new-drug')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async createNewDrug(@UploadedFile() file: Express.Multer.File, @Body('drug') createDrugDto: CreateDrugDto,){
        const createDrug= await this.drugService.createNewDrug(file, createDrugDto);
        return createDrug;
    }

    @Get('/get-drug-list')
    async getDrugList(){
        const drugList=await this.drugService.getDrugList();
        return drugList;
    }
}
import { Body, Controller, Delete, Get, Param, Patch, Post, Query, UploadedFile, UseInterceptors, UsePipes, ValidationPipe } from "@nestjs/common";
import { CreateDrugDto } from "./dto/create_new_drug.dto";
import { DrugService } from "./drug.service";
import { FileInterceptor } from "@nestjs/platform-express";
import { UpdateDrugDto } from "./dto/update_drug.dto";

@Controller('drug')
export class DrugController{
    constructor(private readonly drugService:DrugService){}
    @Post('/create-new-drug')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async createNewDrug(@UploadedFile() file: Express.Multer.File, @Body('drug') createDrugDto: CreateDrugDto | string){
        const createDrug= await this.drugService.createNewDrug(file, createDrugDto);
        return createDrug;
    }

    @Get('/get-drug-list')
    async getDrugList(@Query('skip') skip:number, @Query('limit')limit: number){
        const drugList=await this.drugService.getDrugList(skip, limit);
        return drugList;
    }

    @Get('/search-drug-list')
    async searchDrugList(@Query('skip') skip:number, @Query('limit')limit: number, @Query('search') search: string){
        const drugList=await this.drugService.searchDrugList(skip, limit, search);
        return drugList;
    }

    @Patch('/update-drug')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async updateDrug(@UploadedFile() file: Express.Multer.File, @Body('drug') updateDrugDto: UpdateDrugDto,){
        const updateDrug= await this.drugService.updateDrug(file, updateDrugDto);
        return updateDrug;
    }

    @Delete('/delete-drug/:id')
    async deleteDrug(@Param('id')idThuoc: String){
        const deleteDrug= await this.drugService.deleteDrug(idThuoc);
        return deleteDrug;
    }
}
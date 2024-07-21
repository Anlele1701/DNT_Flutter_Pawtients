import { Body, Controller, Delete, Get, Param, Patch, Post, Query, UploadedFile, UseInterceptors, UsePipes, ValidationPipe } from "@nestjs/common";
import { VacxinService } from "./vacxin.service";
import { FileInterceptor } from "@nestjs/platform-express";
import { CreateNewVacxinDto } from "./dto/create_new_vacxin.dto";
import { UpdateVacxinDto } from "./dto/update_vacxin.dto";

@Controller('vacxin')
export class VacxinController{
    constructor(private readonly vacxinService: VacxinService){}
    @Post('/create-new-vacxin')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async createNewVacxin(@UploadedFile() file: Express.Multer.File ,@Body('vacxin') createvacxinDto: CreateNewVacxinDto | string){
        const newVacxin=this.vacxinService.createNewVacxin(file, createvacxinDto);
        return newVacxin;
    }

    @Get('/get-vacxin-list')
    async getVacxinList(skip: number, limit: number){
        const vacxinList=await this.vacxinService.getVacxinList(skip, limit);
        return vacxinList;
    }

    @Get('/search-vacxin-list')
    async searchVacxinList(@Query('skip') skip: number, @Query('limit') limit: number, @Query('search') search: string){
        const vacxinList=await this.vacxinService.searchVacxinList(skip, limit, search);
        return vacxinList;
    }

    @Patch('/update-vacxin')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async updateVacxin(@UploadedFile() file: Express.Multer.File ,@Body('vacxin') updateVacxinDto: UpdateVacxinDto){
        const updateVacxin=this.vacxinService.updateVacxin(file, updateVacxinDto);
        return updateVacxin;
    }

    @Delete('/delete-vacxin/:id')
    async deleteDrug(@Param('id')idThuoc: String){
        const deleteDrug= await this.vacxinService.deleteVacxin(idThuoc);
        return deleteDrug;
    }
}
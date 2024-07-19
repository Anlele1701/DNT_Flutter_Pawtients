import { Body, Controller, Get, Post, UploadedFile, UseInterceptors, UsePipes, ValidationPipe } from "@nestjs/common";
import { VacxinService } from "./vacxin.service";
import { FileInterceptor } from "@nestjs/platform-express";
import { CreateNewVacxinDto } from "./dto/create_new_vacxin.dto";

@Controller('vacxin')
export class VacxinController{
    constructor(private readonly vacxinService: VacxinService){}
    @Post('/create-new-vacxin')
    @UseInterceptors(FileInterceptor('hinhAnh'))
    @UsePipes(new ValidationPipe())
    async createNewVacxin(@UploadedFile() file: Express.Multer.File ,@Body('vacxin') createvacxinDto: CreateNewVacxinDto){
        const newVacxin=this.vacxinService.createNewVacxin(file, createvacxinDto);
        return newVacxin;
    }

    @Get('/get-vacxin-list')
    async getVacxinList(skip: number, limit: number){
        const vacxinList=await this.vacxinService.getVacxinList(skip, limit);
        return vacxinList;
    }
}
import { Appointment } from 'src/schemas/Appointment.schema';
import { AppointmentService } from './appointment.service';
import { Body, Controller, Get, Param, Patch, Post, Query, UsePipes, ValidationPipe } from '@nestjs/common';
import { CreateAppointmentDto } from './dto/create_new_appointment.dto';
import { ApiTags } from '@nestjs/swagger';
@ApiTags("APPOINTMENT")
@Controller('appointment')
export class AppointmentController{
    constructor(private readonly appointmentService: AppointmentService){}
    @Post('/create-new-appointment')
    @UsePipes(new ValidationPipe())
    async createNewAppointment(@Body('appointment') createAppointmentDto: CreateAppointmentDto, @Body('userID')userID: String): Promise<Appointment>{
        try{
            return await this.appointmentService.createNewAppointment(createAppointmentDto, userID);
        }
        catch(e) {
            console.log(e);
            return e;
        }
    }

    @Get('/get-appointment-list/:id')
    async getAppointmentList(@Param('id') userID: String){
        try{
            const listApp= await this.appointmentService.getAppointmentList(userID);
            return listApp;
        }
        catch(e){
            console.log(e);
            return e;
        }
    }

    @Get('/get-appointment-list')
    async getAllAppointmentList(){
        try{
            const listApp= await this.appointmentService.getAllAppointmentList();
            return listApp;
        }
        catch(e){
            console.log(e);
            return e;
        }
    }

    @Patch('/update-appointment-status')
    async updateAppointmentStatus(@Query('idLichKham') idLichKham: String, @Query('idNV') idNV: String, @Query('trangThai') trangThai: String): Promise<Appointment>{
        try{
            return await this.appointmentService.updateAppointmentStatus(idLichKham, idNV, trangThai);
        }catch(e){
            console.log(e);
            return e;
        }
    }

    @Patch('/update-noti/:id')
    async updateAppointmentNoti(@Param('id') idLichKham: String):Promise<boolean>{
        try{
            return await this.appointmentService.updateAppointmentNoti(idLichKham);
        }
        catch(e){
            console.log(e);
            return e;
        }
    }
}
import { Appointment } from 'src/schemas/Appointment.schema';
import { AppointmentService } from './appointment.service';
import { Body, Controller, Get, Param, Post, UsePipes, ValidationPipe } from '@nestjs/common';
import { CreateAppointmentDto } from './dto/create_new_appointment.dto';
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
}
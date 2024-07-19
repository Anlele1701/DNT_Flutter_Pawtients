import { Appointment } from 'src/schemas/Appointment.schema';
import { AppointmentService } from './appointment.service';
import { Body, Controller, Post, UsePipes, ValidationPipe } from '@nestjs/common';
import { CreateAppointmentDto } from './dto/create_new_appointment.dto';
@Controller('appointment')
export class AppointmentController{
    constructor(private readonly appointmentService: AppointmentService){}
    @Post('/create-new-appointment')
    @UsePipes(new ValidationPipe())
    async createNewAppointment(@Body() createAppointmentDto: CreateAppointmentDto): Promise<Appointment>{
        try{
            return await this.appointmentService.createNewAppointment(createAppointmentDto);
        }
        catch(e) {
            return e;
        }
    }
}
import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Appointment } from "src/schemas/Appointment.schema";
import { CreateAppointmentDto } from "./dto/create_new_appointment.dto";
import { PetService } from "src/schemas/PetService.schema";
import { Pet_Services_Service } from "../pet_service/pet_services.service";

@Injectable()
export class AppointmentService {
    constructor(@InjectModel(Appointment.name) private appointmentModel: Model<Appointment>, private petServicesService: Pet_Services_Service){}
    async createNewAppointment(createAppointmentDto: CreateAppointmentDto){
        try{
            console.log(createAppointmentDto.loaiDichVu);
            var idPetService= await this.petServicesService.findIDPeTService(createAppointmentDto.loaiDichVu);
            createAppointmentDto.loaiDichVu=idPetService;
            const newAppointment= await new this.appointmentModel(createAppointmentDto);
            if(newAppointment){
                newAppointment.save();
                return newAppointment;
            }
            else{
                return 'Failed to create appointment';
            }
        }catch(e){
            console.log(e);
            return e;
        }
    }
}
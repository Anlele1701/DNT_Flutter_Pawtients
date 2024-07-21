import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Appointment, AppointmentSchema } from "src/schemas/Appointment.schema";
import { AppointmentController } from "./appointment.controller";
import { AppointmentService } from "./appointment.service";
import { PetService, PetServiceSchema } from "src/schemas/PetService.schema";
import { Pet_Services_Service } from "../pet_service/pet_services.service";

@Module({
    imports:[
        MongooseModule.forFeature([{name: Appointment.name, schema: AppointmentSchema}]),
        MongooseModule.forFeature([{name: PetService.name, schema: PetServiceSchema}])
    ],
    controllers:[AppointmentController],
    providers:[AppointmentService, Pet_Services_Service]
})
export class AppointmentModule {};
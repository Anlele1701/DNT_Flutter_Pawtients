import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Bill, BillSchema } from "src/schemas/Bill.schema";
import { BillService } from "./bill.service";
import { BillController } from "./bill.controller";
import { Appointment, AppointmentSchema } from "src/schemas/Appointment.schema";

@Module({
    imports:[
        MongooseModule.forFeature([{name: Bill.name, schema: BillSchema}]),
        MongooseModule.forFeature([{name: Appointment.name, schema: AppointmentSchema}]),
    ],
    controllers:[BillController],
    providers:[BillService],
})
export class BillModule{}
import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Pet_Services_Controller } from "./pet_services.controller";
import { Pet_Services_Service } from "./pet_services.service";
import { PetService, PetServiceSchema } from "src/schemas/PetService.schema";

@Module({
    imports:[
        MongooseModule.forFeature([{name: PetService.name, schema: PetServiceSchema}]),
    ],
    controllers:[Pet_Services_Controller],
    providers:[Pet_Services_Service]
})
export class Pet_S_Module{};
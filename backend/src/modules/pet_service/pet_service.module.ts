import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Pet_S_Controller } from "./pet_service.controller";
import { Pet_S_Service } from "./pet_service.service";
import { PetService, PetServiceSchema } from "src/schemas/PetService.schema";

@Module({
    imports:[
        MongooseModule.forFeature([{name: PetService.name, schema: PetServiceSchema}])
    ],
    controllers:[Pet_S_Controller],
    providers:[Pet_S_Service]
})
export class Pet_S_Module{};
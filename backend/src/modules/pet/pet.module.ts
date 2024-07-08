import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Mongoose } from "mongoose";
import { Pet, PetSchema } from "src/schemas/Pet.schema";
import { PetService } from "./pet.service";
import { PetController } from "./pet.controller";

@Module({
    imports:[
        MongooseModule.forFeature([{name: Pet.name, schema: PetSchema}])
    ],
    controllers:[PetController],
    providers:[PetService]
})
export class PetModule{};

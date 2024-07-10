import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Mongoose } from "mongoose";
import { Pet, PetSchema } from "src/schemas/Pet.schema";
import { PetService } from "./pet.service";
import { PetController } from "./pet.controller";
import { User, UserSchema } from "src/schemas/User.schema";

@Module({
    imports:[
        MongooseModule.forFeature([{name: Pet.name, schema: PetSchema}, {name: User.name, schema: UserSchema}])
    ],
    controllers:[PetController],
    providers:[PetService]
})
export class PetModule{};

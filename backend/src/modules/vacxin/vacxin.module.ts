import { Vacxin, VacxinSchema } from './../../schemas/Vacxin.schema';
import { Module } from "@nestjs/common";
import { VacxinController } from "./vacxin.controller";
import { VacxinService } from "./vacxin.service";
import { MongooseModule } from "@nestjs/mongoose";

@Module({
    imports:[
        MongooseModule.forFeature([{name: Vacxin.name, schema: VacxinSchema}])
    ],
    controllers:[VacxinController],
    providers:[VacxinService],
})
export class VacxinModule{};
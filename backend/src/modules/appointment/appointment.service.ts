import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model, Types } from "mongoose";
import { Appointment } from "src/schemas/Appointment.schema";
import { CreateAppointmentDto } from "./dto/create_new_appointment.dto";
import { PetService } from "src/schemas/PetService.schema";
import { Pet_Services_Service } from "../pet_service/pet_services.service";
import { Pet } from "src/schemas/Pet.schema";
import { User } from "src/schemas/User.schema";

@Injectable()
export class AppointmentService {
    constructor(@InjectModel(Appointment.name) private appointmentModel: Model<Appointment>, private petServicesService: Pet_Services_Service, @InjectModel(User.name) private userModel: Model<User>){}
    async createNewAppointment(createAppointmentDto: CreateAppointmentDto, userID: String){
        try{
            const petServiceId= await this.petServicesService.findIDPeTService(createAppointmentDto.loaiDichVu);
            createAppointmentDto.loaiDichVu= petServiceId.toString();
            const newAppointment = new this.appointmentModel(createAppointmentDto);
            if(newAppointment){
                await newAppointment.save();
                const user=await this.userModel.findOne({'_id':userID});
                user.dsLichKham.push(newAppointment.id);
                await user.save();
                console.log(newAppointment);
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

    async getAppointmentList(userID: String): Promise<Appointment[]>{
        try{
            var list: Appointment[] = [];
            const user=await this.userModel.findOne({'_id': userID});
            if(user && user.dsLichKham){
                const appointments = await this.appointmentModel.find({ '_id': { $in: user.dsLichKham } });
                list.push(...appointments);
            }
            console.log(list);
            return list;
        }
        catch(e){
            console.log(e);
            return e;
        }
    }

    async updateAppointmentStatus(idLichKham: String, idNV: String, trangThai: String):Promise<Appointment>{
        try{
            var lichKham=await this.appointmentModel.findOne({'_id':idLichKham});
            if(lichKham){
                lichKham.idNV= idNV;
                lichKham.trangThai=trangThai;
                lichKham.save();
                return lichKham;
            }
            else return null;
        }catch(e){
            console.log(e);
            return e;
        }
    }

    async updateAppointmentNoti(idLichKham: String):Promise<String>{
        try{
            var lichKham= await this.appointmentModel.findOne({'_id':idLichKham});
            if(lichKham){
                lichKham.thongBao=true;
                await lichKham.save();
                return 'Change Noti success';
            }
            else return 'Change Noti failed';
        }
        catch(e){
            console.log(e);
            return e;
        }
    }
}
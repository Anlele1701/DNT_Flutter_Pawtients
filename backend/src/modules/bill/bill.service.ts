import { Appointment } from './../../schemas/Appointment.schema';
import { Bill } from './../../schemas/Bill.schema';
import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from 'mongoose';
import { CreateBillDto } from './dto/create_bill.dto';
import { Image } from "src/schemas/Image";

@Injectable()
export class BillService{
    constructor(@InjectModel(Bill.name) private billModel: Model<Bill>, @InjectModel(Appointment.name) private appointmentModel: Model<Appointment>){}
    async createBill(file: Express.Multer.File[], createBillDto: CreateBillDto |string): Promise<Bill>{
        try{
            let createBillObj: CreateBillDto;
            if (typeof createBillDto === 'string') {
                createBillObj = JSON.parse(createBillDto);
            } else {
                createBillObj = createBillDto;
            }
            file.forEach((item)=>{
                createBillObj.hinhAnh.push(new Image(item.originalname, item.buffer, item.mimetype));
            });
            const newBill= new this.billModel(createBillObj);
            await newBill.save();
            if(newBill){
                var appointment= await this.appointmentModel.findOne({'idHoaDon': newBill.idLichKham});
                appointment.idHoaDon=newBill.id;
                await appointment.save();
                return newBill;
            }
            else return null;
        }catch(e){
            console.log(e);
            return e;
        }
    }
    async getBillList():Promise<Bill[]>{
        try{
            const billList= await this.billModel.find();
            if(billList) return billList;
            else return null;
        }catch(e){
            console.log(e);
            return e;
        }
    }
}
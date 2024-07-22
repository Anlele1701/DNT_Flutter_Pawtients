import { IsNotEmpty } from "class-validator";

export class CreateAppointmentDto{
    @IsNotEmpty({message: 'ngày không được để trống'})
    ngayKham: Date;
    @IsNotEmpty({message: 'Loại dịch vụ không được để trống'})
    loaiDichVu: String;
    tinhTrangBenh: String;
    idThuCung: String;
}
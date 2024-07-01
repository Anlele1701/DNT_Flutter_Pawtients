import { IsNotEmpty, IsNumber } from "class-validator";

export class CreatePetServiceDto{
    @IsNotEmpty({message: "Tên dịch vụ không được rỗng"})
    tenDichVu: String;
    @IsNotEmpty({message: "Mô tả không được rỗng"})
    moTa: String;
    @IsNotEmpty({message: "Giá tiền không được rỗng"})
    @IsNumber()
    giaTien: number;
}
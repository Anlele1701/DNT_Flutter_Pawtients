import { IsNotEmpty, IsNumber } from "class-validator";
import { Image } from "src/schemas/Image";

export class CreatePetDto{
    @IsNotEmpty({message: "Tên dịch vụ không được rỗng"})
    tenThuCung: String;
    @IsNotEmpty({message: "Ngày sinh không được trống"})
    ngaySinh: Date;
    loaiThuCung: String;
    @IsNotEmpty({message: "Sở thích không được rỗng"})
    giongLoai: String;
    @IsNotEmpty({message:"Giới tính không được rỗng"})
    gioiTinh: boolean;
    canNang: String;
    hinhAnh: Image;
}
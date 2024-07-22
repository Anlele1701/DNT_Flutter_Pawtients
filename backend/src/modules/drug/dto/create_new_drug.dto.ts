import { Image } from "src/schemas/Image";

export class CreateDrugDto{
    tenthuoc: String;
    hangThuoc: String;
    moTa: String;
    soLuong: number;
    giaTien: number;
    phongBenh: String;
    hinhAnh: Image;
}
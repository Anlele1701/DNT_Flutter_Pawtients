import { Image } from "src/schemas/Image";

export class UpdateDrugDto{
    id: String;
    tenthuoc: String;
    hangThuoc: String;
    moTa: String;
    soLuong: number;
    giaTien: number;
    phongBenh: String;
    hinhAnh: Image;
}
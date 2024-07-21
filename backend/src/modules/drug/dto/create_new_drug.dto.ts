import { Image } from "src/schemas/Image";

export class CreateDrugDto{
    tenthuoc: String;
    hangThuoc: String;
    moTa: String;
    thanhPhan: String;
    giaTien: number;
    phongBenh: String;
    hinhAnh: Image;
}
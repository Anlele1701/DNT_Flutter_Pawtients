import { Image } from "src/schemas/Image";

export class UpdateDrugDto{
    id: String;
    tenthuoc: String;
    hangThuoc: String;
    moTa: String;
    thanhPhan: String;
    giaTien: number;
    phongBenh: String;
    hinhAnh: Image;
}
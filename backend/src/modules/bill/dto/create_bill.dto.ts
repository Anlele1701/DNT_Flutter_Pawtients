import { Order } from "src/schemas/Order";
import { Image } from "src/schemas/Image";
export class CreateBillDto{
    chanDoan: String;
    keDonThuoc: Order[];
    phiDichVu: String;
    hinhAnh: Image[];
    tongTien: number;
    idLichKham: String;
}
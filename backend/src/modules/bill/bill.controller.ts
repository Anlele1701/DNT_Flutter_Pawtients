import { Body, Controller, Get, Post, UploadedFiles, UseInterceptors, UsePipes, ValidationPipe } from "@nestjs/common";
import { BillService } from "./bill.service";
import { Bill } from "src/schemas/Bill.schema";
import { FileInterceptor, FilesInterceptor } from "@nestjs/platform-express";
import { CreateBillDto } from "./dto/create_bill.dto";
import { ApiTags } from "@nestjs/swagger";
@ApiTags("BILLS")
@Controller('bill')
export class BillController {
  constructor(private readonly billService: BillService) {}
  @Post('/create-bill')
  @UseInterceptors(FilesInterceptor('hinhAnh', 3))
  @UsePipes(new ValidationPipe())
  async createBill(
    @UploadedFiles() file: Express.Multer.File[],
    @Body('bill') createBillDto: CreateBillDto | string,
  ): Promise<Bill> {
    try {
      const bill = await this.billService.createBill(file, createBillDto);
      return bill;
    } catch (e) {
      console.log(e);
      return e;
    }
  }

  @Get('/get-bill-list')
  async getBillList(): Promise<Bill[]> {
    try {
      return await this.billService.getBillList();
    } catch (e) {
      console.log(e);
      return e;
    }
  }
  @Get('/get-bill/:id')
  async getBill(@Param('id') id: string): Promise<Bill> {
    mongoose.Types.ObjectId.isValid(id);
    try {
      return await this.billService.getBill(id);
    } catch (e) {
      console.log(e);
      return e;
    }
  }
}

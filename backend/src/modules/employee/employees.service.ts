import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectModel } from '@nestjs/mongoose';
import { Image } from 'src/schemas/Image';
import { Model } from 'mongoose';
import { Employee } from 'src/schemas/Employee.schema';
import { LoginEmployeeDto } from './dto/LoginEmployee.dto';
import { CreateEmployeeDTO } from './dto/CreateEmployee.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class EmployeesService {
  constructor(
    @InjectModel(Employee.name) private employeeModel: Model<Employee>,
    private jwtService: JwtService,
  ) {}
  async login(loginEmployeesDTO: LoginEmployeeDto) {
    const user = await this.employeeModel.findOne({
      tenTK: loginEmployeesDTO.tenTK,
    });
    if (!user) {
      return { success: false };
    }
    const passwordMatched = await bcrypt.compare(
      loginEmployeesDTO.matKhau,
      user.matKhau.toString(),
    );
    if (!passwordMatched) {
      return { success: false };
    }
    const payload = { id: user._id };
    const token = await this.jwtService.signAsync({ payload });
    return { success: true, token: token };
  }
  async createEmployee(
    image: Express.Multer.File,
    createEmployeeDto: CreateEmployeeDTO,
  ) {
    const hashedPassword = await bcrypt.hash(createEmployeeDto.matKhau, 12);
    const hinhAnh = new Image(image.originalname, image.buffer, image.mimetype);
    const newEmployee = await this.employeeModel.create({
      ...createEmployeeDto,
      matKhau: hashedPassword,
      hinhAnh: hinhAnh,
    });
    const token = this.jwtService.sign({ id: newEmployee._id });
    return { token, success: true };
  }
  async updateEmployee(createEmployeeDto: CreateEmployeeDTO, id: string) {
    console.log(createEmployeeDto.matKhau);
    if (createEmployeeDto.matKhau != null) {
      const hashedPassword = await bcrypt.hash(createEmployeeDto.matKhau, 12);
      await this.employeeModel.findByIdAndUpdate(id, {
        ...createEmployeeDto,
        matKhau: hashedPassword,
      });
    } else {
      await this.employeeModel.findByIdAndUpdate(id, {
        ...createEmployeeDto,
      });
    }
    return { message: 'Cập nhật thành công', success: true };
  }
  async deleteEmployee(id: string) {
    await this.employeeModel.findByIdAndDelete(id);
    return { message: 'Xóa thành công', success: true };
  }
  async getEmployeeInfo(employeeId: string) {
    const employee = await this.employeeModel.findById(employeeId);
    return employee;
  }
  async findByID(id: String): Promise<Employee> {
    return this.employeeModel.findById(id);
  }
}

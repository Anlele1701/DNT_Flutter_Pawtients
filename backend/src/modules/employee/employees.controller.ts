import {
  Body,
  Controller,
  Get,
  Post,
  UseGuards,
  Request,
  NotFoundException,
  UsePipes,
  ValidationPipe,
  Param,
} from '@nestjs/common';
import { EmployeesService } from './employees.service';
import { LoginEmployeeDto } from './dto/LoginEmployee.dto';
import { CreateEmployeeDTO } from './dto/CreateEmployee.dto';
import { AuthGuard } from '../auth.guard';
import mongoose from 'mongoose';

@Controller('employees')
export class EmployeesController {
  constructor(private employeeService: EmployeesService) {}
  @UsePipes(new ValidationPipe())
  @Post('login')
  async login(@Body() loginEmployeesDTO: LoginEmployeeDto) {
    return this.employeeService.login(loginEmployeesDTO);
  }
  @UsePipes(new ValidationPipe())
  @Post('create')
  async register(@Body() createEmployeeDto: CreateEmployeeDTO) {
    return this.employeeService.createEmployee(createEmployeeDto);
  }
  @UseGuards(AuthGuard)
  @Get('getUser')
  async getUser(@Request() req) {
    const empID = req.user.payload.id;
    console.log(empID);
    if (!mongoose.Types.ObjectId.isValid(empID)) {
      return { message: 'ID không hợp lệ' };
    }
    const emp = await this.employeeService.findByID(empID);
    if (!emp) {
      return { message: 'Không tìm thấy nhân viên' };
    }
    return emp;
  }
}

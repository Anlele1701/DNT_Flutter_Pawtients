import { Injectable } from '@nestjs/common';
import { AppointmentGateway } from './noti';

@Injectable()
export class NotiService {
  constructor(private readonly appointmentGateway: AppointmentGateway) {}

  async updateAppointmentStatus(appointmentId: String, status: string) {
    // Gửi thông báo qua WebSocket
    this.appointmentGateway.handleUpdateStatus({ appointmentId, status });
  }
}
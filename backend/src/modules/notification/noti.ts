import { WebSocketGateway, WebSocketServer, SubscribeMessage, MessageBody } from '@nestjs/websockets';
import { Server } from 'socket.io';
@WebSocketGateway()
export class AppointmentGateway {
  @WebSocketServer()
  server: Server;

  @SubscribeMessage('updateStatus')
  handleUpdateStatus(@MessageBody() data: any): void {
    this.server.emit('statusUpdated', data);
  }
}
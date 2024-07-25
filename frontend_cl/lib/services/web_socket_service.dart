import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketService {
  IO.Socket? socket;

  void connect() {
    socket = IO.io('http://10.21.38.127:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket?.connect();

    socket?.onConnect((_) {
      print('connected');
    });

    socket?.on('statusUpdated', (data) {
      print('Status updated: $data');
      // Update UI based on the received data
    });

    socket?.onDisconnect((_) {
      print('disconnected');
    });
  }
}
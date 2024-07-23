import 'package:frontend_ad/models/order.dart';

class CartService {
  int TinhThanhTien(int soLuong, int giaTien) {
    return soLuong * giaTien;
  }

  int TinhTongTien(List<Order?>? list) {
    int sum = 0;
    for (var order in list!) {
      if (order?.thanhTien != null) {
        sum += order!.thanhTien!;
      }
    }
    return sum;
  }

  List<Order?>? RemoveItem(String id, List<Order?>? list) {
    if (list == null) return [];
    int index = list.indexWhere((order) => order?.idThuoc == id);
    if (index != -1) list.removeAt(index);
    return list;
  }

  List<Order?>? addItem(Order? order, List<Order?>? list) {
    if (order != null) list!.add(order);
    return list;
  }
}

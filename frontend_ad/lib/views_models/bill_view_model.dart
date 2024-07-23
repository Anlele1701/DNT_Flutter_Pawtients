import 'package:frontend_ad/api_services/bill_service.dart';
import 'package:frontend_ad/api_services/cart_service.dart';
import 'package:frontend_ad/models/bill.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/order.dart';

class BillViewModel {
  Future<Bill?> createBill(Bill bill, List<ImagePet?>? listHinhAnh) async{
    try{
      return await BillService().createBill(bill, listHinhAnh);
    }catch(e){
      print(e);
      return null;
    }
  }


  Future<List<Bill?>?> getBillList() async{
    try{
      return await BillService().getBillList();
    }catch(e){
      print(e);
      return null;
    }
  }

  int TinhThanhTien(int soLuong, int giaTien){
    return CartService().TinhThanhTien(soLuong, giaTien);
  }

  int TinhTongTien(List<Order?>? list){
    return CartService().TinhTongTien(list);
  }

  List<Order?>? RemoveItem(String id, List<Order?>? list) {
    return CartService().RemoveItem(id, list);
  }

  List<Order?>? addItem(Order? order, List<Order?>? list) {
    return CartService().addItem(order, list);
  }
}
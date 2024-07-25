import 'package:frontend_ad/api_services/customer_service.dart';
import 'package:frontend_ad/models/customer.dart';
class CustomerViewModel{
  Future<List<Customer?>?> getUserList()async{
    try{
      return await CustomerService().getUserList();
    }catch(e){
      print(e);
      return null;
    }
  }
}
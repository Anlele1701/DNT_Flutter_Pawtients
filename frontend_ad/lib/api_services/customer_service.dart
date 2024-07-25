import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/customer.dart';

class CustomerService {
  Future<Customer?> createCustomer(Customer customer) async {
    try {
      final dio = Dio();
      Response response = await dio.post('${devURL}/user/create-user');
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Customer?>?> getUserList() async {
    try {
      final dio = Dio();
      Response response = await dio.get("${devURL}/users/get-user-list");
      if (response.statusCode == 200) {
        List<dynamic> listJson = response.data;
        return listJson.map((item) => Customer.fromJson(item)).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

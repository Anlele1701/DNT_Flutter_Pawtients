import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/bill.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:http_parser/http_parser.dart';

class BillService {
  Future<List<Bill?>?> getBillList() async {
    try {
      final dio = Dio();
      Response response = await dio.get("${devURL}/bill/get-bill-list");
      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        return jsonList.map((item) => Bill.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Bill?> getBill(String id) async {
    try {
      final dio = Dio();
      Response response = await dio.get("${devURL}/bill/get-bill/$id");
      if (response.statusCode == 200) {
        return Bill.fromJson(response.data);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Bill?> createBill(Bill bill, List<ImagePet?>? listHinhAnh) async {
    try {
      final dio = Dio();
      List<MultipartFile> imageFiles = [];
      if (listHinhAnh != null) {
        for (var imagePet in listHinhAnh) {
          if (imagePet != null) {
            imageFiles.add(await MultipartFile.fromBytes(imagePet.data,
                filename: imagePet.filename,
                contentType: MediaType.parse(imagePet.mimetype)));
          }
        }
      }
      FormData formData =
          FormData.fromMap({'bill': bill.toJson(), 'hinhAnh': imageFiles});
      Response response =
          await dio.post("${devURL}/bill/create-bill", data: formData);
      if (response.statusCode == 201) {
        return Bill.fromJson(response.data);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

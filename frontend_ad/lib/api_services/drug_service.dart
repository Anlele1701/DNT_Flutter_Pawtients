import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:http_parser/http_parser.dart';

class DrugService {
  Future<Drug?> createNewDrug(Drug drug, ImagePet image) async {
    final dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'drug': drug.toJson(),
        'hinhAnh': MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: MediaType.parse(image.mimetype),
        ),
      });
      Response response =
          await dio.post('${devURL}/drug/create-new-drug', data: formData);
      return Drug.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Drug?>?> getDrugList(int skip, int limit) async {
    final dio = Dio();
    try {
      List<Drug?> listDrug = [];
      Response response = await dio.get('${devURL}/drug/get-drug-list',
          queryParameters: {'skip': skip, 'limit': limit});
      if (response.statusCode == 200) {
        List<dynamic> drugListJson = response.data;
        listDrug =
            drugListJson.map((drugJson) => Drug.fromJson(drugJson)).toList();
        return listDrug;
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

import 'package:frontend/model/drug_model.dart';
import 'package:frontend/services/drug_service.dart';

class DrugViewModel {
  Future<List<Drug?>?> getDrugs(int skip, int limit) async {
    return DrugService().getDrugs(skip, limit);
  }
}

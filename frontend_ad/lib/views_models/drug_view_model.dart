import 'package:frontend_ad/api_services/drug_service.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';

class DrugViewModel{
  void createNewDrug(Drug drug, ImagePet hinhAnh)async {
    var newDrug= await DrugService().createNewDrug(drug, hinhAnh);
  }
}
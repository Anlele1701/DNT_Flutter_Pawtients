import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/drug_service.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';

class DrugViewModel{
  Future<Drug?> createNewDrug(Drug drug, ImagePet hinhAnh)async {
    Drug? createDrug= await DrugService().createNewDrug(drug, hinhAnh);
    if(createDrug!=null) return createDrug;
    else return null;
  }
}
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

  Future<List<Drug?>?> getDrugList(int skip, int limit)async {
    return await DrugService().getDrugList(skip, limit);
  }

  Future<List<Drug?>?> searchDrugList(int skip, int limit, String search)async {
    return await DrugService().searchDrugList(skip, limit, search);
  }

  Future<Drug?> updateDrug(Drug item, ImagePet hinhAnh) async {
    Drug? updateDrug= await DrugService().updateDrug(item, hinhAnh);
    if(updateDrug!=null) return updateDrug;
    else return null;
  }

  Future<String> deleteDrug(String? id) async{
    String result= await DrugService().deleteDrug(id);
    return result;
  }

  
}
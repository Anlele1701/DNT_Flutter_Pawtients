import 'package:frontend_ad/api_services/vacxin_service.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/vacxin.dart';

class VacxinViewModel{
  Future<Vacxin?> createNewVacxin(Vacxin vacxin, ImagePet hinhAnh)async{
    try{
      Vacxin? createVacxin=await VacxinService().createNewVacxin(vacxin, hinhAnh);
      if(createVacxin!=null) return createVacxin;
      else return null;
    }catch(e){
      print(e);
      return null;
    }
  }
  Future<List<Vacxin?>?> getVacxinList(int skip, int limit)async{
    try{
      return await VacxinService().getVacxinList(skip, limit);
    }catch(e){
      print(e);
      return null;
    }
  }
}
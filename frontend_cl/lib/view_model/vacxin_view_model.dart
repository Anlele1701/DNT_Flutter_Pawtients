import 'package:frontend/model/vacxin_model.dart';
import 'package:frontend/services/vacxin_service.dart';

class VacxinViewModel{
  Future<List<Vacxin?>?> getVacxin(int skip, int limit)async{
    try{
      return await VacxinService().getVacxin(skip, limit);
    }catch(e){
      print(e);
    }
  }
}
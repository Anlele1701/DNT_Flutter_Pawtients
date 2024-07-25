import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/user_model.dart';
import 'package:frontend/services/user_service.dart';

class UserViewModel {
  updateUser(User user, ImagePet hinhAnh) async {
    return UserService().updateUser(user, hinhAnh);
  }
}

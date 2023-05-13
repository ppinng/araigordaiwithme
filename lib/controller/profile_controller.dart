import 'package:araigordaiwithme/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:araigordaiwithme/models/model_userinfo.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = FirebaseAuth.instance.currentUser!.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateUserInformation(Usersinformation user) async{
    await _userRepo.updateUserInformation(user);
  }
}

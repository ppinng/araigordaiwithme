import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:araigordaiwithme/models/model_userinfo.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<Usersinformation> getUserDetails(String email) async {
    final snapshot = await _db
        .collection("UsersInfo")
        .where("email", isEqualTo: email)
        .get();
    final userData =
        snapshot.docs.map((e) => Usersinformation.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<Usersinformation>> allUsers() async {
    final snapshot = await _db.collection("UsersInfo").get();
    final userData =
        snapshot.docs.map((e) => Usersinformation.fromSnapshot(e)).toList();
    return userData;
  }
}

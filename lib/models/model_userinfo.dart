import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
final users = FirebaseAuth.instance.currentUser;
class Usersinformation {
  final String uid;
  final String email;
  final int age;
  final int height;
  final int weight;
  final List<String> foods;

  Usersinformation({
    required this.uid,
    required this.email,
    required this.age,
    required this.height,
    required this.weight,
    required this.foods,
  });

  toJson() {
    return {
      'uid': uid,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
      'foods': List<dynamic>.from(foods.map((food) => food)),
    };
  }

  factory Usersinformation.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Usersinformation(
      uid: data["uid"],
      email: data["email"],
      age: data["age"],
      height: data["height"],
      weight: data["weight"],
      foods: List<String>.from(["foods"].map((food) => food)),
    );
  }
  Future<void> addUserInformationToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    final CollectionReference usersInfo =
        FirebaseFirestore.instance.collection('UsersInfo');
    final Map<String, dynamic> userInfo = {
      'uid': users?.uid,
      'email': users?.email,
      'age': age,
      'height': height,
      'weight': weight,
      'foods': List<dynamic>.from(foods.map((food) => food)),
    };
    await usersInfo.doc(user!.uid).set(userInfo);
  }

}

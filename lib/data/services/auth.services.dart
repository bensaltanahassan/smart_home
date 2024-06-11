import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home/data/model/user.model.dart';

class AuthServices {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child("auth");

  Future<bool> login(String email, String password) async {
    try {
      final data = await ref.get();
      final mapData = Map<String, dynamic>.from(data.value as Map);

      final userModel = UserModel.fromJson(mapData);
      return userModel.email == email && userModel.password == password;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

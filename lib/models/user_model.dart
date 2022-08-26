import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? user_id;
  String? display_name;
  String? email;
  String? last_signed_in;
  String? created_on;
  bool? is_new_user;

  UserModel(this.user_id, this.display_name, this.email, this.last_signed_in,
      this.created_on, this.is_new_user);

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    user_id = documentSnapshot.id;
    email = documentSnapshot["email"];
    display_name = documentSnapshot["display_name"];
    last_signed_in = documentSnapshot["last_signed_in"];
    created_on = documentSnapshot["created_on"];
    is_new_user = documentSnapshot["is_new_user"];
  }
}
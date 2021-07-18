
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:multidelivery/src/infra/datasources/usermodel.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';

class FirebaseUserModel extends DatasourceUserModel {
  final _db = FirebaseFirestore.instance;

  @override
  Future<UserModel> create(UserModel userModel) async {
       await _db.collection('users').doc(userModel.id)
      .set(userModel.toMap());
      return userModel;
    }
  
    @override
    Future<UserModel> getUser(String idUser)async {
      final getUserFirebase = await _db.collection('users').doc(idUser).get();
      return UserModel.fromMap(getUserFirebase.data());
    }
  
    @override
    Future<UserModel> update(UserModel userModel)async {
      await _db.collection('users').doc(userModel.id)
      .update(userModel.toMap());
      return userModel;
  }
  
}
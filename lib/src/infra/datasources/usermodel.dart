

import 'package:multidelivery/src/infra/models/usermodel.dart';

abstract class DatasourceUserModel {
  Future<UserModel>create(UserModel userModel);
  Future<UserModel>getUser(String idUser);
  Future<UserModel>update(UserModel userModel);
}
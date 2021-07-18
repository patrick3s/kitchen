


import 'package:multidelivery/src/domain/entities/usermodel.dart';

class UserModel  extends ResultUserModel{
  String name;
  String email;
  String password;
  Map address;
  List favorites;
  String phoneNumber;
  UserModel({
     this.name,
     this.favorites,
     this.email,
     this.password,
     this.address,
     this.phoneNumber
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'favorites':favorites,
      'phoneNumber':phoneNumber
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      favorites: map['favorites'] ?? [],
      password: map['password'] ?? '',
      address: map['address'] ?? {},
      phoneNumber: map['phoneNumber'] ?? ''
    );
  }


}

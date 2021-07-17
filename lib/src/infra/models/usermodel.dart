


import 'package:multidelivery/src/domain/entities/usermodel.dart';

class UserModel  extends ResultUserModel{
  String name;
  String email;
  String password;
  Map address;
  String phoneNumber;
  UserModel({
     this.name,
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
      'phoneNumber':phoneNumber
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? {},
      phoneNumber: map['phoneNumber'] ?? ''
    );
  }


}

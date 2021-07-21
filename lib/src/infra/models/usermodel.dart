


import 'package:multidelivery/src/domain/entities/usermodel.dart';

class UserModel  extends ResultUserModel{
  String name;
  String email;
  String lastName;
  String password;
  Map address;
  List favorites;
  String phoneNumber;
  String birthday;
  UserModel({
     this.name,
     this.favorites,
     this.email,
     this.lastName,
     this.password,
     this.address,
     this.phoneNumber,
     this.birthday
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'favorites':favorites,
      'phoneNumber':phoneNumber,
      'lastName':lastName,
      'birthday':birthday
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      favorites: map['favorites'] ?? [],
      password: map['password'] ?? '',
      lastName: map['lastName'] ?? '',
      address: map['address'] ?? {},
      birthday: map['birthday'] ?? '',
      phoneNumber: map['phoneNumber'] ?? ''
    );
  }


}

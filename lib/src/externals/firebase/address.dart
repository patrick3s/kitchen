

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/infra/datasources/address.dart';

class FirebaseAddress extends DatasourceAddress {
  final _db = FirebaseFirestore.instance;
  @override
  Future<bool> create(Map<String, dynamic> address,String idUser) async{
    await _db.collection('users').doc(idUser).collection('address').add(address);
    return true;
  }

  @override
  Future<bool> delete(String idDoc, String idUser) async{
    await _db.collection('users').doc(idUser).collection('address')
    .doc(idDoc).delete();
    return true;
  }
}
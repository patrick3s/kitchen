import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/infra/datasources/partners.dart';
import 'package:multidelivery/src/infra/models/partner.dart';

class FirebasePartners extends DatasourcePartners{
  final _db = FirebaseFirestore.instance;
  @override
  Future<List<Partner>> search(Map city) async {
    final partnerInFirebase = await _db.collection('partners').
    where('city',isEqualTo: city['city']).
    where('uf',isEqualTo: city['uf']).
    get();
    return partnerInFirebase.docs.map((e) => Partner.fromMap(e.data()..['id'] = e.id)).toList();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/infra/datasources/offers.dart';
import 'package:multidelivery/src/infra/models/offer.dart';

class FirebaseOffers extends DatasourceOffers {
  final _db = FirebaseFirestore.instance;
  @override
  Future<List<Offer>> search(Map city) async{
    final resulOfferInFirebase = await _db.collection('offers').
    where('city',isEqualTo: city['city']).
    where('uf',isEqualTo: city['uf']).get();
    return resulOfferInFirebase.docs.map((e) => Offer.fromMap(e.data()..['id'] = e.id)).toList();
  }

}
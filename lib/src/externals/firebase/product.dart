
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/infra/datasources/product.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class FirebaseProduct extends DatasourceProduct {
  final db = FirebaseFirestore.instance;
  @override
  Future<List<Product>> call(ResultPartner partner) async{
    final productsInFirebase = await db.collection('partners').doc(partner.id).collection('products').get();
    return productsInFirebase.docs.map((e) => Product.fromMap(e.data()..['id']=e.id..['partnerId']=partner.id)).toList();
  }
}
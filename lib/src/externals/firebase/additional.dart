import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/infra/datasources/additioanal.dart';
import 'package:multidelivery/src/infra/models/additional.dart';

class FirebaseAdditional extends DatasourceAddtional {
  final _db = FirebaseFirestore.instance;
  @override
  Future<List<Additional>> call() async{
    final ingredientsFirebase = await _db.collection('ingredients').get();
    return ingredientsFirebase.docs.map((e) => Additional.fromMap(e.data()..['id']= e.id)).toList();
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/infra/datasources/category.dart';
import 'package:multidelivery/src/infra/models/category.dart';

class FirebaseCategory extends DatasourceCategory{
  final db = FirebaseFirestore.instance;
  @override
  Future<List<Category>> search() async{
    final categoryInFirebase = await db.collection('categories').get();
    return categoryInFirebase.docs.map((e) => Category.fromMap(e.data()..['id']= e.id)).toList();
  }
}
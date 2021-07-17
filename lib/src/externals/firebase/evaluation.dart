

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multidelivery/src/infra/datasources/evaluation.dart';
import 'package:multidelivery/src/infra/models/evaluation.dart';

class FirebaseEvaluation extends DatasourceEvaluation {
  final _db = FirebaseFirestore.instance;
  @override
  Future<bool> create(Map<String, dynamic> evaluation) async{
      await _db.collection('partners')
      .doc(evaluation['partnerId']).collection('evaluation').add(evaluation);
      return true;
    }
  
    @override
    Future<List<Evaluation>> search(String idPartner) async {
    final evaluationInFirebase = await _db.collection('partners')
    .doc(idPartner).collection('evaluation').get();
    return evaluationInFirebase.docs.map((e) => Evaluation.fromMap(e.data()..['id']=e.id)).toList();
  }
}
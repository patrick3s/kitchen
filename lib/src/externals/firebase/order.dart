import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:multidelivery/src/infra/datasources/orders.dart';
import 'package:multidelivery/src/infra/models/order.dart';

class FirebaseOrder extends DatasourceOrders {
  final _db = FirebaseFirestore.instance;
  @override
  Future<Order> create(Order order) async{
      final createInFirebase = await _db.collection('partners')
      .doc(order.partner.id).collection('orders').add(order.toMap());
      order.id = createInFirebase.id;
      await _db.collection('users').doc(order.userId).collection('orders').doc(order.id).set({
        'orderId':order.id,
        'partnerId':order.partner.id,
        'userId':order.userId,
        'createAt':order.createAt.millisecondsSinceEpoch
      });
      return order;
    }
  
    @override
    Future<List<Order>> getAll(String idUser) async{
      final ordersInFirebaseByUser = await _db.collection('users').doc(idUser)
      .collection('orders').get();
      List<Order> orders = [];
      List<String> visitorPartners = [];
      for(final doc in ordersInFirebaseByUser.docs){
        if(!visitorPartners.contains(doc.data()['partnerId'])){
          visitorPartners.add(doc.data()['partnerId']);
          final ordersFirebase = await _db.collection('partners').doc(doc.data()['partnerId'])
        .collection('orders').where('userId',isEqualTo: true).get();
        final list = ordersFirebase.docs.
        map((e) => Order.fromMap(doc.data()..['id']=doc.id)).toList();
        orders.addAll(list);
        }
      }
      return orders;
    }
  
    @override
    Future<Order> update(Order order) async {
    await _db.collection('partners').doc(order.partner.id)
    .collection('orders').doc(order.id).update(order.toMap());
    return order;
  }
}
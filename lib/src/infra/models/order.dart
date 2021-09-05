import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:multidelivery/src/domain/entities/order.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/payment.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:multidelivery/src/infra/models/schedule.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';
import 'package:multidelivery/utils/models.dart';

class Order extends ResultOrder {
  String id;
  Partner partner;
  DateTime createAt;
  String createAtFormat;
  List<Product> products;
  bool delivery;
  UserModel userModel;
  double totalPrice;
  double subTotalPrice;
  double thing;
  int status;
  FormPayment formPayment;
  ScheduleOrder scheduleOrder ;
  String userId;
  Order({
    this.id,
    this.partner, 
    this.subTotalPrice,
    this.createAt, 
    this.products , 
    this.delivery, 
    this.userId,
    this.status,
    this.createAtFormat,
    this.userModel, 
    this.totalPrice, 
    this.scheduleOrder,
    this.thing, 
    this.formPayment});

  Map<String, dynamic> toMap() {
    return {
      'partner': partner.toMap(),
      'createAt': createAt.millisecondsSinceEpoch,
      'products': products?.map((x) => x.toMap())?.toList(),
      'delivery': delivery,
      'userModel': userModel.toMap(),
      'totalPrice': totalPrice,
      'id':id,
      'status':status,
      'userId':userId,
      'scheduleOrder':scheduleOrder?.toMap(),
      'subTotalPrice':subTotalPrice,
      'thing': thing ?? 0.0,
      'formPayment': formPayment.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    final date = DateTime.fromMillisecondsSinceEpoch(map['createAt']);
    final f = DateFormat('HH:mm dd/MM/yyyy' );
    return Order(
      partner: Partner.fromMap(map['partner']),
      createAt: date,
      createAtFormat: f.format(date),
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
      delivery: map['delivery'],
      userId: map['userId'],
      status: map['status'],
      userModel: UserModel.fromMap(map['userModel']),
      totalPrice: map['totalPrice'],
      subTotalPrice:map['subTotalPrice'],
      id: map['id'],
     scheduleOrder: map['scheduleOrder' ]!= null ?ScheduleOrder.fromMap(map['scheduleOrder']) : initSchedule(),
      thing: map['thing'],
      formPayment: FormPayment.fromMap(map['formPayment']),
    );
  }

  static ScheduleOrder initSchedule(){
    return ScheduleOrder(
    title: 'Hoje',
    days: [],
    intervals: []
  );
  }

  String toJson() => json.encode(toMap());
  String dateOrderFormat(){
    
    return "${weekdayList[createAt.weekday -1]}.${createAt.day < 10 ?"0${createAt.day}":"${createAt.day}"} ${monthList[createAt.month -1]} ${createAt.year}";
  }

  String deliveryFreeOrPaid(){
    if(delivery == false){
      return "Grátis";
    }
    if(partner == null){
      return null;
    }
    return partner.deliveryPrice == 0.0 ? "Grátis" : "R\$${partner.deliveryPrice.toStringAsFixed(2).replaceAll('.',',')}";
  }

  String statusTextOrder(){
    if(status < lastStatus) return listStats(status,delivery);
    if(status >= lastStatus && status <= lastStatus+1 ) return listStats(lastStatus,delivery);
    return "Cancelado";
  }

  bool statusDoneForVote(){
    final days = DateTime.now().difference(createAt).inDays;
    return days < 15 && status == lastStatus;
  }
  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

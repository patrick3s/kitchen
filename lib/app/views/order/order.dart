

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/error/error.dart';
import 'package:multidelivery/app/views/order/widgets/address.dart';
import 'package:multidelivery/app/views/order/widgets/evaluation.dart';
import 'package:multidelivery/app/views/order/widgets/header.dart';
import 'package:multidelivery/app/views/order/widgets/payment.dart';
import 'package:multidelivery/app/views/order/widgets/products.dart';
import 'package:multidelivery/shared/config.dart';

import 'package:multidelivery/src/infra/models/order.dart';

class OrderView extends StatefulWidget {
  final Map<String,dynamic> map;
  const OrderView({ Key key,this.map }) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  Size size;
  @override
  void initState() {
    AppModule.to<Config>().showLog('OrderView iniciado');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('OrderView destruido');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Detalhes do pedido',
        style: TextStyle(
          fontSize: size.width * .045,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange
        ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('partners').doc(widget.map['partnerId'])
        .collection('orders').doc(widget.map['orderId']).snapshots(),
        builder: (context, snapshot) {
          Order order;
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            return Center(
              child: SpinKitThreeBounce(color: Colors.deepOrange,
              size: 26,
              ),
            );
            break;
            default:
            order = Order.fromMap(snapshot.data.data()..['id'] = snapshot.data.id);
            break;
          }
          if(snapshot.hasError){
            return ErrorView();
          }
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children:[
                      HeaderOrder(order:order,size:size),
                  ProductsOrder(
                    order:order,
                    size: size,
                  ),
                  PaymentOrder(
                    order:order,
                    size:size
                  ),

                AddressOrder(
                  order: order,
                  size: size,
                ),
                    ]
                  ),
                ),
                
                EvaluationOrders(
                  order: order,
                  size:size
                )

              ],
            ),
          );
        }
      ),
    );
  }
}
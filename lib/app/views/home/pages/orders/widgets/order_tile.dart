


import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:transparent_image/transparent_image.dart';

class OrderTile extends StatelessWidget {
  final Map<String,dynamic> doc;
  OrderTile({ Key key,this.doc }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('partners').doc(doc['partnerId'])
      .collection('orders').doc(doc['orderId']).snapshots(),
      builder: (context, snapshot) {
        Order order;
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          return Center(
            child: SpinKitThreeBounce(
              size: 26,
              color: Colors.deepOrange,
            ),
          );
          break;
          default:
          order = Order.fromMap(snapshot.data.data()..['id']=snapshot.data.id);
          break;
        }

        if(snapshot.hasError){
          return Center(
            child: Text('Desculpe, houve um erro ao recuperar pedido',
            style: TextStyle(
              fontSize: size.width * .045
            ),
            ),
          );
        }
        if(!snapshot.data.exists){
          return Container(
            height: AppBar().preferredSize.height,
            child: Text('Desculpe houve um erro'),
          );
        }
        return InkWell(
          onTap: (){
            Modular.to.pushNamed('order', arguments: doc);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.dateOrderFormat(),
                style: TextStyle(
                  fontSize: size.width * .035
                ),
                ),
                SizedBox(height:10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _img(order, size),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order.partner.name,
                                  style: TextStyle(
                                    fontSize: size.width * .05
                                  ),
                                  ),
                                  Text(order.partner.specialtyCategory.title+' '+order.partner.specialtyCategory.emoji,
                                  style: TextStyle(
                                    fontSize: size.width * .035
                                  ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text(order.statusTextOrder(),
                            style: TextStyle(
                              fontSize: size.width * .04
                            ),
                            )),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: .12,horizontal: 1.5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Text(order.products[0].quantity.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * .045,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                                SizedBox(width:10),
                                Expanded(
                                  child: AutoSizeText(order.products[0].name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: size.width * .045
                                  ),
                                  ),
                                )
                              ],
                            ),
                            order.products.length > 1 ? Text('mais ${order.products.length -1} item',
                            style: TextStyle(
                              fontSize: size.width * .035,
                              fontWeight: FontWeight.bold
                            ),
                            ) : Container(),
                            Divider(),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:order.statusDoneForVote() ?  MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                                children: [
                                  order.statusDoneForVote() ? InkWell(
                                    onTap: (){
                                      Modular.to.pushNamed('evaluation',arguments: order);
                                    },
                                    child: Text('Avaliar',
                                    style: TextStyle(
                                      fontSize: size.width * .045,
                                      color: Colors.deepOrange
                                    ),
                                    ),
                                  ): Container(),
                                  Text('Detalhes',
                                  style: TextStyle(
                                    fontSize: size.width * .045,
                                    color: Colors.deepOrange
                                  ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
  _img(Order order, Size size){
    return Container(
      padding: EdgeInsets.all(5),
      height: size.width * .17,
      width:  size.width * .17,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(360)),
        child: FadeInImage.memoryNetwork(placeholder:kTransparentImage , 
        image: order.partner.img,
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}
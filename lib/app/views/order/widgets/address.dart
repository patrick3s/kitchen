
import 'package:flutter/material.dart';
import 'package:multidelivery/src/infra/models/order.dart';

class AddressOrder extends StatelessWidget {
  final Order order;
  final Size size;
  const AddressOrder({ Key key,this.size,this.order }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.delivery ? 'Endereço para entrega' : 'Endereço de retirada',
          style: TextStyle(
            fontSize: size.width * .04,
            color: Colors.grey
          ),
          ),
          order.delivery ? _user(order) : _partner(order),
          Divider()
        ],
      ),
    );
  }

  _partner(Order order){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${order.partner.street},${order.partner.numberHome} - ${order.partner.complement}",
        style: TextStyle(
          fontSize: size.width * .05,
        ),
        ),
        Text("${order.partner.district} - ${order.partner.city} - ${order.partner.uf}",
        style: TextStyle(
          fontSize: size.width * .05,
        ),
        ),
        Text("|${order.partner.reference}",
        style: TextStyle(
          fontSize: size.width * .045,
          color: Colors.grey
        ),
         )
      ],
    );
  }
  _user(Order order){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${order.userModel.address['street'].trim()},${order.userModel.address['numberHome']} - ${order.userModel.address['complement']}",
        style: TextStyle(
          fontSize: size.width * .05,
        ),
        ),
        Text("${order.userModel.address['district']} - ${order.userModel.address['city']} - ${order.userModel.address['uf']}",
        style: TextStyle(
          fontSize: size.width * .05,
        ),
        ),
         Text("|${order.userModel.address['reference']}",
        style: TextStyle(
          fontSize: size.width * .045,
          color: Colors.grey
        ),
         )
      ],
    );
  }
}
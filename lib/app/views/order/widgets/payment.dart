import 'package:flutter/material.dart';
import 'package:multidelivery/src/infra/models/order.dart';

class PaymentOrder extends StatelessWidget {
  final Order order;
  final Size size;
  const PaymentOrder({ Key  key,this.order,this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:[
        _row('subtotal', 'R\$'+order.subTotalPrice.toStringAsFixed(2).replaceAll('.', ','), false),
          _row('Taxa de entrega', order.deliveryFreeOrPaid(), false),
          _row('Total', 'R\$'+order.totalPrice.toStringAsFixed(2).replaceAll('.', ','), true),
          Divider(),
          Text('Pago no ${order.formPayment.name}',
          style: TextStyle(
            fontSize: size.width * .05,
            fontWeight: FontWeight.bold
          ),
          ),
          Divider()
          
        ]
      ),
    );
  }

  _row(String title, String subtitle, bool bold){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
          style: TextStyle(
            fontSize: bold ? size.width * .055 : size.width * .045,
            fontWeight: bold ?FontWeight.bold : FontWeight.normal
          ),
          ),
          Text(subtitle,
          style: TextStyle(
            fontSize: bold ? size.width * .055 : size.width * .04,
            fontWeight: bold ?FontWeight.bold : FontWeight.normal
          ))
        ],
      ),
    );
  }
}
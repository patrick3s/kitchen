import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/cart.dart';

class ResumeOrder extends StatelessWidget {
  final Size size;
  final CartPresenter presenter;
  const ResumeOrder({ Key key,this.presenter,this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:10),
      child: Column(
        children: [
          Text('Resumo do pedido',
          style: TextStyle(
            fontSize: size.width * .052,
            fontWeight: FontWeight.bold
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal',style: TextStyle(
                fontSize: size.width * .04,
                fontWeight: FontWeight.bold
              ),),
              Text('R\$'+presenter.controller.cartModel.order.subTotalPrice.toStringAsFixed(2).replaceAll('.', ','),
              style: TextStyle(
                fontSize: size.width * .04,
                fontWeight: FontWeight.bold
              ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Valor do frete',style: TextStyle(
                fontSize: size.width * .04,
                fontWeight: FontWeight.bold,
                color: Colors.brown
              ),),
              Text(presenter.controller.cartModel.order.deliveryFreeOrPaid(),
              style: TextStyle(
                fontSize: size.width * .04,
                fontWeight: FontWeight.bold,
                color: Colors.brown
              ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',style: TextStyle(
                fontSize: size.width * .05,
                fontWeight: FontWeight.bold
              ),),
              Text('R\$'+presenter.controller.cartModel.order.totalPrice.toStringAsFixed(2).replaceAll('.', ','),
              style: TextStyle(
                fontSize: size.width * .05,
                fontWeight: FontWeight.bold
              ),
              )
            ],
          )
        ],
      ),
    );
  }
}
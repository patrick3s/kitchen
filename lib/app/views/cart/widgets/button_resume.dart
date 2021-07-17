import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/presenters/cart.dart';

class ButtonResume extends StatelessWidget {
  final Size size;
  final CartPresenter presenter;
  const ButtonResume({ Key key,this.size,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15),
      height: size.height * .085,
      child: Row(
        children: [
          Column(
            children: [
              Text('Total',style: TextStyle(
                fontSize: size.width * .05,
                fontWeight: FontWeight.bold
              ),),
              Text('R\$'+presenter.controller.cartModel.order.totalPrice.toStringAsFixed(2).replaceAll('.', ','),
              style: TextStyle(
                fontSize: size.width * .05,
              ),
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:10),
              height:size.height * .06,
              child: ElevatedButton(onPressed: (){
                Modular.to.pushNamed('cart_confirmation');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange
              ), 
              child: Text('Continuar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.width * .045
              ),
              )),

            ),
          )
        ],
      ),
    );
  }
}
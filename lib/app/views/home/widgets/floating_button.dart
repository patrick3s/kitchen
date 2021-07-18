





import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_module.dart';


import 'package:multidelivery/shared/icons_platform.dart';

import 'package:multidelivery/shared/pallete_colors.dart';
import 'package:multidelivery/src/infra/models/cart.dart';









class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = AppModule.to<CartModel>();
    return Container(

      child: Center(
        heightFactor: .6,
        child: ValueListenableBuilder<int>(
          valueListenable: cart.quantityItems,
          builder: (context, value,child) {
            return Stack(
              children: [
                FloatingActionButton(
                  child: Icon(IconsPlatform.cart,
                      color: Colors.black,
                      size: 30,
                      ),
                  backgroundColor: secondaryColor,
                  onPressed: (){
                   Modular.to.pushNamed('cart');
                  },),
                  Positioned(
                        top: 0,
                        right: 0,
                        child: 
                      Card(
                        elevation: value == 0 ? 0 : 10,
                        color: value == 0 ? Colors.transparent: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(360))),
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: Text(value == 0 ? '': value.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                          )),
                      ))
              ],
            );
          }
        ),
      ),
    );
  }
}
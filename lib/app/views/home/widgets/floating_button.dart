





import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


import 'package:multidelivery/shared/icons_platform.dart';

import 'package:multidelivery/shared/pallete_colors.dart';









class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.6,
      child: FloatingActionButton(
        child: Icon(IconsPlatform.cart,
        color: Colors.black,
        size: 30,
        ),
        backgroundColor: secondaryColor,
        onPressed: (){
         Modular.to.pushNamed('cart');
        },),
    );
  }
}
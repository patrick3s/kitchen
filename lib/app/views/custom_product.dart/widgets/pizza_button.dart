import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/custom_product.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/shared/pallete_colors.dart';

class PizzaButton extends StatelessWidget {
  final Size size;
  final PresenterCustomProduct presenter;
  const PizzaButton({Key key, this.size, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            secondaryColor,
            primaryColor.withOpacity(.8),
          ])),
      child: Center(
        child: Icon(
          IconsPlatform.cart,
          size: size.width * .5,
        ),
      ),
    );
  }
}

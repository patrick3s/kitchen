import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:multidelivery/blocs/additional.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class CustomProductController {
  final BlocAdditional bloc;
  final Product product;
  final CartModel cartModel;
  int size = 0;
  AnimationController animationController;
  List<Animation> animationsList = [];
  CustomProductController(this.bloc,this.product,this.cartModel);

  buildIngredientsAnimation(){
    animationsList.clear();
    animationsList.add(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2,0.65,curve: Curves.decelerate))
    );
    animationsList.add(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3,0.5,curve: Curves.decelerate))
    );
    animationsList.add(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2,0.55,curve: Curves.decelerate))
    );
    animationsList.add(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4,0.5,curve: Curves.decelerate))
    );
    animationsList.add(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3,0.6,curve: Curves.decelerate))
    );
  }
}
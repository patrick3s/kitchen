
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/controllers/cart.dart';
import 'package:multidelivery/src/infra/models/product.dart';

abstract class CartContract {
  refresh();
}

class CartPresenter {
  final CartContract _contract;
  final CartController controller;
  CartPresenter(this._contract, this.controller);
  cleanCart(){
    controller.cartModel.clearCart();
    Modular.to.pop();
  }

  update(){
    Modular.to.pop();
    controller.refresh();
    _contract.refresh();
  }
  removeItem(Product product){
    Modular.to.pop();
    controller.cartModel.removeProduct(product);
    controller.refresh();
    _contract.refresh();
    
    
  }
}
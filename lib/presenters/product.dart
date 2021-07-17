import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/controllers/product.dart';
import 'package:multidelivery/src/infra/models/product.dart';

abstract class ProductContract{
  refresh();
  error(Product product);
}

class ProductPresenter {
  
  final ProductContract _contract;
  final ProductController controller;

  ProductPresenter(this._contract, this.controller);

  addProduct(Product product)async{
    if(controller.validator() != null) return null;
    final added = controller.cart.addProduct(product);
    if(added){
      Modular.to.pushReplacementNamed('cart');
      return;
    }
    _contract.error(product);
  }
  
}
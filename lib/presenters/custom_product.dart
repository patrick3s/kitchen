import 'package:multidelivery/controllers/custom_product.dart';
import 'package:multidelivery/src/infra/models/product.dart';

abstract class CustomProductContract {
  refresh();
   error(Product product);
}

class PresenterCustomProduct {
  final CustomProductContract _contract;
  final CustomProductController controller;
  PresenterCustomProduct(this._contract, this.controller);
  addProduct(Product product)async{
    final added = controller.cartModel.addProduct(product);
    if(added){
      //animação;
      
      return;
    }
    _contract.error(product);
  }
  setSize(int value){
    controller.size = value;
    _contract.refresh();
  }
}
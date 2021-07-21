import 'package:multidelivery/src/infra/models/cart.dart';

class CartController {
  final CartModel cartModel;

  CartController(this.cartModel);
  refresh(){
    if(!cartModel.isEmpty.value)cartModel.refreshCart();
    
  }

}
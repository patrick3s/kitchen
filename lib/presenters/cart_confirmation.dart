import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/blocs/orders.dart';
import 'package:multidelivery/controllers/cart_confirmation.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/order.dart';

abstract class CartConfirmationContract {
  notification(text);
  confirmation();
  success(Order order);
}

class CartConfirmationPresenter {
 final CartConfirmationContract _contract;
 final CartConfirmationController controller;
  CartConfirmationPresenter(this._contract, this.controller);
  validation(){
    final hasError = controller.validator();
    if(hasError != null){
      _contract.notification(hasError);
      return;
    }
    _contract.confirmation();
  }

  saveOrder()async{
    final order = await controller.saveOrder();
    if(order is ErrorOrder){
      _contract.notification(order.error.error);
      return;
    }else if(order is SuccessOrderWrite){
      AppModule.to<CartModel>().clearCart();
      _contract.success(order.order);
    }
    
  }
 
}
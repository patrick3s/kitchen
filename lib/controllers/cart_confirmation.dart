import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:multidelivery/blocs/orders.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/cart.dart';


class CartConfirmationController {
  final fieldController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final AuthUser auth;
  final CartModel cart;
  final BlocOrder blocOrder;
  CartConfirmationController(this.cart,this.auth,this.blocOrder);
  String validator(){
    cart.order.createAt = DateTime.now();
    cart.order.userModel = auth.userModel;
    cart.order.userId = auth.user.uid;
    cart.order.status = 0;
    if(cart.order.formPayment == null){
      return 'Escolha uma forma de pagamento';
    }
    if(cart.order.formPayment.notThing){
      return null;
    }
    final text = fieldController.text.replaceAll(',', '');
    final value = double.parse(text.isEmpty ? '0.0' : text);
    if(value < cart.order.totalPrice){
      return 'O troco não pode ser menor que o valor total';
    }
    cart.order.thing =value;
    return null;
  }

  saveOrder()async{
    final order = blocOrder.create(cart.order);
    return order;
  }
}
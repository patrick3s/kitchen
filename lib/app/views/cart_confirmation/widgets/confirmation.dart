
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/common/delivery.dart';
import 'package:multidelivery/blocs/orders.dart';
import 'package:multidelivery/presenters/cart_confirmation.dart';

class Confirmation extends StatelessWidget {
  final CartConfirmationPresenter presenter;
  Confirmation({ Key key,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        height: size.height * .7,
        child: Column(
          children: [
            Center(
              child: Text('Por favor confirme as informações',
              style: TextStyle(
                fontSize:size.width * .045,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DeliveryCart(
              size: size,
              cartModel: presenter.controller.cart,
            ),
            Text('Forma de pagamento:',style: TextStyle(
              fontSize: size.width * .045,
            ),),
            Text('Pagamento no ${presenter.controller.cart.order.formPayment.name}',
            style: TextStyle(
              color:Colors.deepOrange,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height:15),
            Text('Total',
            style: TextStyle(
              fontSize: size.width * .045,
              fontWeight: FontWeight.bold
            ),
            ),
            Text('R\$${presenter.controller.cart.order.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: size.width * .05,
              fontWeight: FontWeight.bold
            ),
            ),
            Expanded(child: StreamBuilder<OrderState>(
              stream: presenter.controller.blocOrder.stream,
              builder: (context, snapshot) {
                if(snapshot.data is LoadingOrder){
                    return LayoutBuilder(

                      builder: (context, constraints) {
                        return Container(
                          height: constraints.maxHeight * .9,
                          width: constraints.maxHeight * .9,
                          child: Image.asset('assets/loading.gif',
                          fit: BoxFit.cover,
                          ),
                        );
                      }
                    );
                  }
                return Container();
              }
            )),
            Container(
              height: size.height * .06,
              width: size.width,
              child:StreamBuilder<OrderState>(
                stream: presenter.controller.blocOrder.stream,
                builder: (context, snapshot) {
                  if(snapshot.data is LoadingOrder){
                    return Center(
                      child: SpinKitThreeBounce(
                        color:Colors.deepOrange,
                        size: 25,
                        ),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange
                    ),
                    child: Text('Concluir pedido',
                  style: TextStyle(
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  onPressed:presenter.saveOrder,
                  );
                }
              ))
            
          ],
        ),
      ),
    );
  }
}
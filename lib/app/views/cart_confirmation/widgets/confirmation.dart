
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/common/delivery.dart';
import 'package:multidelivery/app/common/schedule.dart';
import 'package:multidelivery/blocs/orders.dart';
import 'package:multidelivery/presenters/cart_confirmation.dart';

class Confirmation extends StatelessWidget {
  final CartConfirmationPresenter presenter;
  Confirmation({ Key key,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder<bool>(
        valueListenable: presenter.controller.cart.isEmpty,
        builder: (context, value, child) {
          if(value){
            return Container();
          }
          return FormField<bool>(

            builder: (state) {
              
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                height: size.height * .8,
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
                      refresh: (){
                        Future.delayed(Duration.zero).then((value){
                          presenter.controller.cart.refreshCart();
                          state.didChange(presenter.controller.cart.order.delivery);
                        }
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScheduleViewOrder(
                        size: size,
                        ignoring: true,
                        cart: presenter.controller.cart,
                        partner: presenter.controller.cart.order.partner,
                        refresh: (){
                          Future.delayed(Duration.zero).then((value){
                            presenter.controller.cart.refreshCart();
                            state.didChange(presenter.controller.cart.order.delivery);
                          });
                        },
                      ),
                    ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children:[
                       Column(children: [
                            Text('Forma de pagamento:',style: TextStyle(
                        fontSize: size.width * .045,
                      ),),
                      Text('Pagamento no ${presenter.controller.cart.order.formPayment.name}',
                      style: TextStyle(
                        color:Colors.deepOrange,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                       ],),

                      Column(
                        children: [
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
                      )
                        ],
                      )
                       ]
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
              );
            }
          );
        }
      ),
    );
  }
}
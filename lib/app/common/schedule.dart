import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class ScheduleViewOrder extends StatelessWidget {
  final CartModel cart;
  final Partner partner;
  final bool ignoring;
  final Size size;
  final Function refresh;
  ScheduleViewOrder({ Key key,this.cart,this.size,this.partner,this.refresh,this.ignoring }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FormField<CartModel>(
        builder: (state) {
          if(refresh != null){
            refresh();
          }
          return Row(
            children: [
              _tileDelivery(state),
              _tileSchedule()
            ],
          );
        }
      ),
    );
  }
  _tileDelivery(FormFieldState<CartModel> state){
    return IgnorePointer(
      ignoring: ignoring ?? false,
      child: DropdownButton<bool>(
        value: cart.order.delivery,
        underline: Container(),
        
        onChanged: (value){
          cart.order.delivery = value;
  state.didChange(cart);
        },
        items: [true,false].map((e) =>
        DropdownMenuItem(
          value: e,
          child: Container(
            color: Colors.grey.withOpacity(.5),
            padding: EdgeInsets.all(size.width * .008),
            child: Container(
              child: Text(e ? 'Entrega' :'Retirar',
              style: TextStyle(
                fontSize: size.width * .045
              ),
              ),
            ),
          ))
         ).toList()),
    );
  }
  _tileSchedule(){
    return Expanded(
            child: InkWell(
              onTap: (){
                if(partner.scheduleOrder.intervals.isEmpty){
                  notificationPopup('Desculpe', "Esse parceiro não aceita agendamentos.");
                  return;
                }
                Modular.to.pushNamed('schedule', arguments: partner);
              },
              child: Container(
                color: Colors.grey.withOpacity(.5),
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(cart.order.scheduleOrder.title,style: TextStyle(
                        fontSize: size.width *.045,
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(',${partner.deliveryTime}',style: TextStyle(
                        fontSize: size.width *.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown
                      ),
                      maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(' - ${cart.order.deliveryFreeOrPaid() ?? partner.deliveryPriceFormat()}',style: TextStyle(
                        fontSize: size.width *.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown
                      ),
                      maxLines: 1,
                      ),
                    ),

                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(onPressed: null, 
                        icon: Icon(IconsPlatform.arrowForward)),
                      ),
                    )
                    ],
                ),
              ),
            ),
          );
  }
}
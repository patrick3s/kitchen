import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/schedule.dart';
import 'package:multidelivery/presenters/partner.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:transparent_image/transparent_image.dart';

class HeaderPartner extends StatelessWidget {
  final Size size;
  final PartnerPresenter presenter;
   HeaderPartner({ Key key,this.presenter,this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tile(),
         _detail(),
         ScheduleViewOrder(cart: AppModule.to<CartModel>(),
         partner: presenter.controller.partner,
         refresh: (){
           Future.delayed(Duration.zero).then((value) => presenter.refresh());
         },
         size: size,
         )
        ],
      ),
    );
  }
  _tile(){
    return Container(
      padding: EdgeInsets.only(bottom:8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(presenter.controller.partner.name,
            style: TextStyle(
          fontSize: size.width * .06,
          fontWeight: FontWeight.bold
            ),
            ),
            Text(presenter.controller.partner.specialtyCategory.title,
            style: TextStyle(
              fontSize: size.width * .04,
              color: Colors.grey
            ),
            ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(360)),
            child: Container(
              height: size.width * .15,
              width: size.width * .15,
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage ,
               image: presenter.controller.partner.img,
               fit: BoxFit.cover,
               ),

            ),
          )
        ],
      ),
    );
  }

  _detail(){
    _tileRow(String title,String subtitle){
      return Column(
        children: [
          Text(title,
          style: TextStyle(
            fontSize:size.width * .07,
            color: Colors.orange
          ),
          ),
          Text(subtitle,
          style: TextStyle(
            fontSize: size.width * .035,
            color: Colors.blueGrey
          ),
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: presenter.controller.partner.isNew() ? null : (){
            Modular.to.pushNamed('partner_evaluation',
            arguments: presenter.controller.partner);
          },
          child: _tileRow(presenter.controller.partner.isNew() ? 'Novo':'⭐️',presenter.controller.partner.isNew() ? '' : presenter.controller.partner.averange.toStringAsFixed(2).replaceAll('.', ','))),
        _tileRow('⏰',presenter.controller.partner.deliveryTime),
        _tileRow(presenter.controller.partner.specialtyCategory.emoji,
         presenter.controller.partner.specialtyCategory.title),
        _tileRow('🛵',
        AppModule.to<CartModel>().order.delivery ?
        presenter.controller.partner.deliveryPriceFormat() :
        "Grátis"
        )
      ],
    );
  }
}
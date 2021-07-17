import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/cart.dart';
import 'package:transparent_image/transparent_image.dart';

class InfoPartner extends StatelessWidget {
  final Size size;
  final CartPresenter presenter;
  const InfoPartner({ Key key,this.size,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12
          )
        )
      ),
      child: Row(
        children: [
          Container(
            height: size.width * .18,
            width: size.width * .18,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(360)),
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
               image: presenter.controller.cartModel.order.partner.img,
               fit: BoxFit.cover,
               ),
              ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Text(presenter.controller.cartModel.order.partner.name,
            style: TextStyle(
              fontSize: size.width * .05,
              fontWeight: FontWeight.bold
            ),
            ),
          )
        ],
      ),
    );
  }
}
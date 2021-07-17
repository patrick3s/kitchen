import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/evaluation.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:transparent_image/transparent_image.dart';

class AppBarEvaluation extends StatelessWidget {
  final EvaluationPresenter presenter;
  final Size size;
  const AppBarEvaluation({ Key key,this.size,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children:[
              _img(presenter.controller.order),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(presenter.controller.order.partner.name,
                  style: TextStyle(
                    fontSize: size.width * .05
                  ),
                  ),
                  Text(presenter.controller.order.partner.specialtyCategory.title,
                  style: TextStyle(
                    fontSize: size.width * .035,
                    color: Colors.grey
                  ),
                  ),
                ],
              )
            ]
          ),
          Divider()
        ],
      ),
    );
  }
  _img(Order order){
    return Container(
      height: size.width * .17,
      width: size.width * .17,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(360)),
        child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
        image: order.partner.img,
        fit: BoxFit.cover,
        ),
        ),
    );
  }
}
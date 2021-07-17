import 'package:flutter/material.dart';
import 'package:multidelivery/controllers/partner_evaluation.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:rating_bar/rating_bar.dart';

class HeaderEvaluation extends StatelessWidget {
  final Partner partner;
  final PartnerEvaluationController controller;
  HeaderEvaluation({Key key, this.partner,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Text(
            partner.averange.toStringAsFixed(1).replaceAll('.', ','),
            style: TextStyle(fontSize: size.width * .1),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RatingBar.readOnly(
              initialRating: 3.5,
              isHalfAllowed: true,
              size: size.width * .08,
              filledColor: Colors.orangeAccent,
              halfFilledIcon: IconsPlatform.starHalf,
              filledIcon: IconsPlatform.star,
              emptyIcon: IconsPlatform.starBorder,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${controller.evaluations.length} avaliações"),
          ),
          Container(height:1,
          width:double.infinity,
          color:Colors.grey.withOpacity(.5)
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:multidelivery/utils/models.dart';

class EvaluationOrders extends StatelessWidget {
  final Order order;
  final Size size;
  const EvaluationOrders({Key key, this.order, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8),
      color:  Colors.grey.withOpacity(.15),
      child: order.status < lastStatus ? Container() : Card(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: order.status == lastStatus
              ? InkWell(
                  onTap: () {
                    // show avaliar
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(IconsPlatform.star,
                        color: Colors.orange,
                        ),
                        Text(
                          'Avaliar',
                          style: TextStyle(fontSize: size.width * .05),
                        ),
                      ],
                    ),
                  ),
                )
              :  order.status == lastStatus + 1 ? 
              Center(child: Text('Obrigado pela sua avaliação',
                style: TextStyle(
                  fontSize:  size.width * .045,
                  fontWeight: FontWeight.bold
                ),
                ),)
              : Column(children: [
                Text('Seu prazo de avaliação foi finalizado',
                style: TextStyle(
                  fontSize:  size.width * .045,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height:10),
                Text('Você tem até 15 dias para avaliar o pedido',
                style: TextStyle(
                  fontSize:  size.width * .035,
                  
                ),
                )
              ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:multidelivery/utils/models.dart';
import 'package:transparent_image/transparent_image.dart';

class HeaderOrder extends StatelessWidget {
  final Order order;
  final Size size;
  const HeaderOrder({Key key, this.order, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Row(children: [
              Container(
                padding: EdgeInsets.all(5),
                height: size.width * .18,
                width: size.width * .18,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(360)),
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
                  image: order.partner.img,
                  fit: BoxFit.cover,
                  ),
                  ),
              ),
              Text(order.partner.name,
              style: TextStyle(
                fontSize: size.width * .045,
                fontWeight: FontWeight.bold
              ),
              )
            ],),
          ),
          order.scheduleOrder.selectHour != null ? _schedule():Container(),
          Row(
            children: [
              Text(
                'Realizado ás ',
                style:
                    TextStyle(color: Colors.grey, fontSize: size.width * .035),
              ),
              Text(
                order.createAtFormat.replaceAll(
                  ' ',
                  ' - ',
                ),
                style:
                    TextStyle(color: Colors.grey, fontSize: size.width * .035),
              ),
              Expanded(child: InkWell(
                onTap: (){
                  Modular.to.pushNamed('partner',arguments: order.partner);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text('Ver cardapio',
                  style: TextStyle(
                    fontSize: size.width * .035,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ))
            ],
          ),
          Container(
            padding: EdgeInsets.only(top:10),
            child: order.status >= lastStatus  && order.status <= lastStatus+1? Container(
              padding: EdgeInsets.all(12),
              color: Colors.grey.withOpacity(.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    IconsPlatform.checkmark,
                    size: size.width * .045,
                    color: Colors.green,
                  ),
                  Text('Pedido concluido',
                  style: TextStyle(
                    fontSize: size.width * .047,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ],
              ),
            ):
            order.status == 5 ? cancel():
            ExpansionTile(title: Text(listStats[order.status < listStats.length ? order.status : 3],
            style: TextStyle(
              fontSize: size.width * .045,
              fontWeight: FontWeight.bold
            ),
            ),
            children: [
              ...List.generate(listStats.length, (index) {
                if( index < order.status){
                  return Text(listStats[index],
                  style: TextStyle(
                    fontSize: size.width * .045,
                    color: Colors.grey
                  ),
                  );
                }
                return Container();
              }).toList().reversed.toList()
            ],
            ),
          )

        ],
      ),
    );
  }
  _schedule(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Text('Pedido agendado para ${order.scheduleOrder.title} no horário de ${order.scheduleOrder.selectHour.formatString()}' ,
      style: TextStyle(
        fontSize: size.width * .045,
        color: Colors.brown
      ),
      ),
    );
  }

  cancel(){
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.grey.withOpacity(.5),
      child: Text('Seu pedido foi cancelado, Ligue para saber mais ${order.partner.phoneNumber}',
      style: TextStyle(
        fontSize: size.width * .045,
        fontWeight: FontWeight.bold
      ),
      ),
    );
  }
}

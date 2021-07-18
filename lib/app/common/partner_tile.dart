
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:transparent_image/transparent_image.dart';

class PartnerTile extends StatelessWidget {
  final Size size;
  final Partner partner;
  const PartnerTile({ Key key,this.size,this.partner }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _partner(partner),
    );
  }
  _partner(Partner partner) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Modular.to.pushNamed('partner',arguments: partner);
            },
            child: Column(
              children: [
                Row(
                  children:[
                    _img(partner.img),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          Text(partner.name,
                          style: TextStyle(
                            fontSize: size.width * .05,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          Row(
                            children: [
                              Text(partner.isNew() ? "Novo": partner.averange.toStringAsFixed(1).replaceAll('.', ','),
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .04
                              ),
                              ),
                              
                              Icon(IconsPlatform.star,
                              size: size.width * .04,
                              color: Colors.orangeAccent,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Text(partner.specialtyCategory.emoji,
                                style: TextStyle(
                                  fontSize: size.width * .03
                                ),
                                ),
                              ),
                              Text(partner.specialtyCategory.title,
                              style: TextStyle(
                                  fontSize: size.width * .035
                                ),
                              )
                            ],
                          ),
                          Text("${partner.deliveryTime} ° ${partner.deliveryPrice == 0 ? "Entrega Gratis" : "R\$${partner.deliveryPrice.toStringAsFixed(2)}"} 🛵",
                          style: TextStyle(
                            fontSize: size.width * .03
                          ),
                          )
                        ],
                      ),
                    ),
                   !partner.isOpen ? Container(
                      padding: EdgeInsets.all(15),
                      child: Text('Fechado',
                      style: TextStyle(
                        fontSize: size.width * .045,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    ) : Container()
                  ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _img(String img){
    return Container(
      height: size.width * .15,
      width: size.width * .15,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(360)),
        child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
         image: img,
         fit: BoxFit.cover,
         ),
      ));
  }
}
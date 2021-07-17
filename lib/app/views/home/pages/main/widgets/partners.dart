import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/presenters/page_main.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:transparent_image/transparent_image.dart';

class Partners extends StatelessWidget {
  final BlocPartners blocPartners;
  final MainPresenter presenter;
  final Size size;
  Partners({Key key, this.blocPartners, this.presenter,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<PartnerState>(
          stream: blocPartners.stream,
          builder: (context, snapshot) {
            
            if (snapshot.data is SuccessPartner) {
              presenter.controller
                  .setPartners((snapshot.data as SuccessPartner).list);
            }

            if (snapshot.data is LoadingPartner) {
              return Container(
                height: 150,
                width: double.infinity,
                child: SpinKitThreeBounce(
                  size: 20,
                  color: Colors.deepOrange,
                ),
              );
            }

            if (presenter.controller.partners.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Center(
                  child: Text(
                    'Ainda não há parceiros disponiveis na sua região ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            return FormField<int>(
                key: presenter.controller.formPartners,
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    if (presenter.controller.getPartners().isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top:18.0),
                        child: Text('Não foi encontrado nenhum parceiro com essa especialidade',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(top:8.0,bottom: 12),
                        child: Text('Parceiros',
                        style: TextStyle(
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                      ...presenter.controller
                          .getPartners()
                          .map((e) => _partner(e))
                          .toList()
                    ]
                  ]);
                });
          }),
    );
  }

  _partner(Partner partner) {
    return Column(
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

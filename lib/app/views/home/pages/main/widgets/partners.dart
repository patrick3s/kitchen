import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/common/partner_tile.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/presenters/page_main.dart';



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
                          .map((e) => PartnerTile(
                            partner: e,
                            size: size
                          ))
                          .toList()
                    ]
                  ]);
                });
          }),
    );
  }

 }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/blocs/offers.dart';
import 'package:multidelivery/presenters/page_main.dart';
import 'package:multidelivery/src/infra/models/offer.dart';
import 'package:transparent_image/transparent_image.dart';

class Offers extends StatelessWidget {
  final BlocOffers blocOffers;
  final Size size;
  final currentId = ValueNotifier<String>('');
  final MainPresenter presenter;
  Offers({ Key key,this.blocOffers,this.size ,this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OfferState>(
        stream: blocOffers.stream,
          initialData: IdleOffers(),
          builder: (context, snapshot) {
            if(snapshot.data is LoadingOffers){
              return Container(
                height: size.height * .25,
                width: double.infinity,
                child: Center(
                  child: SpinKitThreeBounce(
                    size: 20,
                    color: Colors.deepOrange,
                  ),
                ),
              );
            }
            if(snapshot.data is ErrorOffers){
              return Container(
                height: size.height * .25,
                width: double.infinity,
                child: Center(
                  child: Text('Desculpe houve um erro, tente novamente mais tarde',
                  style: TextStyle(
                    fontSize: size.width * .04
                  ),
                  ),
                ),
              );
            }
            if(snapshot.data is SuccessOffers){
               presenter.controller.offers = (snapshot.data as SuccessOffers).list;
              if(presenter.controller.offers.isEmpty) return Container();
              presenter.controller.startAnimationOffers();
              return Container(
                height: size.height * .25,
                width: double.infinity,
                child: PageView.builder(
                  controller: presenter.controller.pageControllerOffers,
                  itemCount: presenter.controller.offers.length,
                  onPageChanged: (page){
                   currentId.value = presenter.controller.offers[page].id;
                  },
                  itemBuilder: (context, index){
                    if(currentId.value == '') currentId.value = presenter.controller.offers[0].id;
                    return _tile(presenter.controller.offers[index]);
                  }),
              );
            }
          return Container(
            
          );
        }
      );
  }

  _tile(Offer offer){
    return ValueListenableBuilder(
      valueListenable: currentId,
      builder: (context, current ,snapshot) {
        return LayoutBuilder(          
          builder: (context, constrains) {
        
            return Container(
              height: constrains.maxHeight,
              width: constrains.maxWidth,
             
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: constrains.maxHeight * .7,
                    width: size.width * .78,
                    
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Stack(children: [
                       Container(
                          height: constrains.maxHeight * .7,
                          width: size.width * .78,
                          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
                         image: offer.img,
                         fit: BoxFit.cover,
                         ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                              )
                            ),
                            height: constrains.maxHeight * .15,
                            alignment: Alignment.center,
                            width: size.width * .3,
                           child: Text('R\$ ${offer.price.toStringAsFixed(2)}',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: size.width * .05
                           ),
                           ), 
                          ))
                      ],),
                      ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: current == offer.id ? 1.0: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(offer.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: constrains.maxHeight * .11
                          ),
                          ),
                          Text(offer.product.partnerName,
                          style: TextStyle(fontSize: constrains.maxHeight * .09,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87.withOpacity(.8)
                          ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/blocs/additional.dart';
import 'package:multidelivery/presenters/custom_product.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/additional.dart';
import 'package:transparent_image/transparent_image.dart';

class PizzaIngredients extends StatelessWidget {
  final Size size;
  final PresenterCustomProduct presenter;
  final controller = ScrollController();
 PizzaIngredients({ Key key,this.presenter,this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AdditionalState>(
      stream: presenter.controller.bloc.stream,
      builder: (context, snapshot) {
        if(snapshot.data is LoadingAdditional){
          return Center(
            child: SpinKitThreeBounce(
              size: 26,
              color: Colors.deepOrange,
            ),
          );
        }
        if(snapshot.data is ErrorAdditional){
          return Center(child: TextButton(onPressed: (){}, child: Text('Houve um erro, tente novamente.')));
        }
        if(snapshot.data is IdleAdditional){
          return Container();
        }
        final list = (presenter.controller.bloc.value as SuccessAdditional).list;

        return Row(
          children: [
            Container(
              child: IconButton(onPressed: (){
                controller.animateTo(controller.position.minScrollExtent +20,
                 duration: Duration(milliseconds: 900), curve: Curves.decelerate);

              }, icon: Icon(IconsPlatform.arrowBack)),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                return _pizzaItem(list[index]);
              }),
            ),
            Container(
               child: IconButton(onPressed: (){
                 controller.animateTo(controller.position.maxScrollExtent -20, duration: Duration(milliseconds: 900)
                 , curve: Curves.decelerate);
               }, icon: Icon(IconsPlatform.arrowForward)),
            )
          ],
        );
      }
    );
  }

  _pizzaItem(Additional additional){
    final child = Padding(
        padding: const EdgeInsets.symmetric(horizontal:7.0,vertical: 4),
        child: Container(
          height: size.width * .13,
          width: size.width * .13,
          decoration: BoxDecoration(
            color: Color(0xFFF5DED3),
            shape: BoxShape.circle
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
            image: additional.img,
            fit: BoxFit.contain,
            ),
          ),
        ),
      );
    return Draggable(
      feedback: Column(
        children: [
          Material(
            color: Colors.white38,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(additional.title.toUpperCase(),
          style: TextStyle(
              fontSize: size.width * .05,
              color: Colors.brown,
              fontWeight: FontWeight.bold
          ),
          ),
            )),
          SizedBox(height: 20,),
          DecoratedBox(
            child: child,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(0.0,5.0),
                  color: Colors.black26,
                  spreadRadius: 3
                )
              ]
            )),
            
        ],
      ),
      data: additional,
      child: child,
      
    );
  }
}


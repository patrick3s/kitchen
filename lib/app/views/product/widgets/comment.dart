import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/product.dart';
import 'package:multidelivery/shared/icons_platform.dart';


class CommentProduct extends StatelessWidget {
  final ProductPresenter presenter;
  final Size size;
   CommentProduct({ Key key,this.presenter,this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
     child: Column(
       children: [
         Row(
           children: [
             Icon(IconsPlatform.chat),
             Text(' Alguma observação?',
             style: TextStyle(
               fontSize: size.width * .045
             ),
             )
           ],
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextFormField(
             onChanged: (text){
               presenter.controller.product.comment = text;
             },
             maxLines: null,
             style: TextStyle(
               fontSize: size.width * .045
             ),
             decoration: InputDecoration(
               border: OutlineInputBorder(),
               hintStyle: TextStyle(
                 fontSize: size.width * .045
               ),
               hintText: 'Ex: Retirar cebola, carne ao ponto \ne  etc ...'
             ),
           ),
         )
       ],
     ), 
    );
  }
}
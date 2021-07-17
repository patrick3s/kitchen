import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/presenters/cart.dart';

class AddItem extends StatelessWidget {
  final Size size;
  final CartPresenter presenter;
  AddItem({ Key key,this.size,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Modular.to.pop();
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12
            )
          )
        ),
        child: Text('Adicionar mais items',
        style: TextStyle(
          fontSize: size.width * .05,
          color: Colors.deepOrange
        ),
        ),
      ),
    );
  }
}
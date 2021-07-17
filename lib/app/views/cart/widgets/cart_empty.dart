import 'package:flutter/material.dart';

class CartEmpty extends StatelessWidget {
  final Size size;
  const CartEmpty({ Key key ,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Image.asset('assets/carrinho_vazio.png',
                ),
              ),
            )),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text('Seu carrinho está vazio.',
                  style: TextStyle(
                    fontSize: size.width * .05,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ],
              ),
            ))
        ],
      ),
    );
  }
}
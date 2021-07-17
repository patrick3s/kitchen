

import 'package:flutter/material.dart';

class AppBarOrders extends StatelessWidget {
  const AppBarOrders({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: AppBar().preferredSize.height,
      width: double.infinity,
      child: Text('Meus Pedidos',
      style: TextStyle(
        fontSize: size.width * .045
      ),
      ),
    );
  }
}
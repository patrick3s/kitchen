import 'package:flutter/material.dart';
import 'package:multidelivery/src/infra/models/order.dart';

class ProductsOrder extends StatelessWidget {
  final Order order;
  final Size size;
  ProductsOrder({ Key key,this.size,this.order }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Pedido id ${order.id}',
            style: TextStyle(
              fontSize: size.width * .045,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          Divider(),
          ...order.products.map((product) => Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3)
                    ),
                    child: Text(product.quantity.toString(),
                    style: TextStyle(
                      fontSize: size.width * .04,
                      fontWeight: FontWeight.bold
                    ),
                    )),
                    SizedBox(width:4),
                  Text(product.name,
                  style: TextStyle(
                    fontSize: size.width * .04
                  ),
                  ),
                  Expanded(child: Container(
                    alignment: Alignment.centerRight,
                    child:  Text('R\$'+product.price.toStringAsFixed(2).replaceAll('.',','),
                  style: TextStyle(
                    fontSize: size.width * .04
                  ),
                  ),))
                ],
              ),
            ),
            ...product.complements.map((complement) => Column(children: [
              ...complement.selected.map((additional) => additional.quantity > 0 ? Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(additional.title,
                    style: TextStyle(
                      fontSize: size.width * .035,
                      color: Colors.grey
                    ),
                    ),
                    additional.price > 0 ? Text("R\$${additional.price.toStringAsFixed(2).replaceAll('.', ',')}",
                    style: TextStyle(
                      fontSize: size.width * .035,
                      color: Colors.grey
                    ),
                    ): Container(),
                  ],
                ),
              ):Container()).toList()
            ],)).toList()
          ],)).toList(),
          Divider(),
         
          
        ],
      ),
    );
  }
  
}
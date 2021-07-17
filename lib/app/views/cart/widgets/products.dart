import 'package:flutter/material.dart';
import 'package:multidelivery/app/common/show_modal.dart';
import 'package:multidelivery/app/views/cart/widgets/detail_product.dart';
import 'package:multidelivery/presenters/cart.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsCart extends StatelessWidget {
  final Size size;
  final CartPresenter presenter;
  const ProductsCart({ Key key,this.size,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...presenter.controller.cartModel.order.products.map((e) => _tileProduct(e)).toList()
        ],
      ),
    );
  }

  _tileProduct(Product product){
    return InkWell(
      onTap: (){
        
        showModalWidget(DetailProduct(
          presenter: presenter,
          product: product,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            bottom:BorderSide(
              color: Colors.black26
            )
          )
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                          style: TextStyle(
                            fontSize: size.width * .05,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical:8.0),
                             child: Text(product.description,
                          style: TextStyle(
                              fontSize: size.width * .05,
                              color: Colors.grey
                          ),
                          ),
                           ),
                        ],
                      ),
                    ),
                    Text('R\$${product.totalPrice().toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontSize: size.width * .05,
                      color: Colors.brown
                    ),
                    )
                  ],
                ),
              )),
              Container(
                height:size.width * .18,
                width: size.width * .18,
                child: Stack(
                  children: [
                   product.img.isNotEmpty ? Container(
                      height:size.width * .18,
                width: size.width * .18,
                      child: ClipRRect(
                        child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                         image: product.img,
                         fit: BoxFit.cover,
                         ),
                         ),
                    ) : Container(),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Card(
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(360))
                        ),
                        child: Container(
                          height: size.width * .06,
                          width: size.width * .06,
                          alignment: Alignment.center,
                          child:Text(product.quantity.toString(),
                        style: TextStyle(
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        )
                        ),
                      ) )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
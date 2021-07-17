

import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/cart.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailProduct extends StatelessWidget {
  final Product product;
  final CartPresenter presenter;
   DetailProduct({ Key key,this.presenter,this.product }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final newProduct = Product.fromMap(product.toMap());
    return Material(
      child: Container(
        padding: EdgeInsets.all(10),
        height: size.height * .4,
        child: Column(
          children:[
            Text(product.name,
            style: TextStyle(
              fontSize: size.width * .05,
              fontWeight: FontWeight.bold
            ),
            ),
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: Text(product.description,
                    style: TextStyle(
                      fontSize: size.width * .045,
                      color: Colors.grey
                    ),
                    )),
                    product.img.isNotEmpty ? Container(
                      height: size.width * .18,
                      width: size.width * .18,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(360)),
                        child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
                        image: product.img,
                        fit: BoxFit.cover,
                        ),
                        ),
                    ) : Container()
                  ],
                ),
              ),
            ),
            FormField<int>(
              initialValue: newProduct.quantity,
              builder: (state) {
                newProduct.quantity = state.value;
                return Container(
                  height: size.height * .07,
                  child: Row(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              state.didChange(state.value +1);
                            },
                             icon: Icon(IconsPlatform.add)),
                            Text(state.value.toString(),
                            style: TextStyle(
                              fontSize: size.width * .05
                            ),
                            ),
                            IconButton(onPressed: (){
                              if( state.value > 1) state.didChange(state.value -1);
                                
                            }, 
                            icon: Icon(IconsPlatform.remove))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * .06,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrange
                                ),
                                child: Text('Atualizar',
                              style: TextStyle(
                                fontSize: size.width * .045,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              onPressed: (){
                                product.quantity = newProduct.quantity;
                                presenter.update();
                              },
                              ),
                            
                            ),
                            Container(
                              height: size.height * .06,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrange
                                ),
                                child: Text('Remover',
                              style: TextStyle(
                                fontSize: size.width * .045,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              onPressed: (){
                                presenter.removeItem(product);
                              },
                              ),
                            
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            )
          ]
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:transparent_image/transparent_image.dart';

class HeaderProduct extends StatelessWidget {
  final Product product;
  final Size size;
HeaderProduct({ Key key ,this.product,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product.img.isEmpty ? Container(): Center(
            child: Container(
              padding: EdgeInsets.all(8),
              height: size.height * .3,
              width: size.height * .3,
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
              image: product.img,
              fit: BoxFit.cover,
              ),
            ),
          ),

          Text(product.name,
          style: TextStyle(
            fontSize: size.width * .05
          ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical:8),
            child: Text(product.description,
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * .04
            ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(IconsPlatform.home,
                size: size.width * .06,
                ),
                Text(product.partnerName.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * .05
                ),
                )
              ],
            ),
          ),
          product.custom ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color:Colors.deepOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
              onPressed: (){
                Modular.to.pushNamed('custom_product',arguments: product);
              }, child: Text('Monte sua pizza 🍕',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: size.width * .045,
                fontWeight: FontWeight.bold
                
              ),
              ))),
          ) : Container()
        ],
      ),
    );
  }
}
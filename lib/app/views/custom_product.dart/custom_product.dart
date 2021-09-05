

import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/custom_product.dart/widgets/pizza_button.dart';
import 'package:multidelivery/app/views/custom_product.dart/widgets/pizza_details.dart';
import 'package:multidelivery/app/views/custom_product.dart/widgets/pizza_ingredients.dart';
import 'package:multidelivery/blocs/additional.dart';
import 'package:multidelivery/controllers/custom_product.dart';
import 'package:multidelivery/presenters/custom_product.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class CustomProduct extends StatefulWidget {
  final Product product;
  const CustomProduct({ Key key ,this.product}) : super(key: key);

  @override
  _CustomProductState createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProduct> implements CustomProductContract{
  Size size;
  PresenterCustomProduct presenter;
  Size _pizzaButtonSize;
  @override
  void initState() {
    AppModule.to<Config>().showLog('Customproduct iniciada');
    super.initState();
    presenter = PresenterCustomProduct(
      this,
      CustomProductController(
        AppModule.to<BlocAdditional>(),
        widget.product,
        AppModule.to<CartModel>()
      )
    );
  }

@override
void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _pizzaButtonSize = Size(
      size.width * .12,
      size.width * .12
    );
  }
@override
dispose(){
  super.dispose();
  AppModule.to<Config>().showLog('Customproduct destruido');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [IconButton(onPressed: (){}, icon: Icon(IconsPlatform.cart))],
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('R\$ ${(widget.product.sizes[presenter.controller.size]['price'] + 0.0).toStringAsFixed(2).replaceAll('.',',')}',
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * .055,
          fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Expanded(
                    flex:4,
                    child: PizzaDetails(
                    size: size,
                    presenter: presenter,
                  )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          child: PizzaIngredients(
                          size:size,
                          presenter:presenter
                  ),
                        ),
                        SizedBox(height:size.width* .085)
                      ],
                    ))
                ],
              ),
            ),
          ),
           Positioned(
             bottom:25,
             height: _pizzaButtonSize.height,
             width: _pizzaButtonSize.width,
             left: (size.width / 2) - _pizzaButtonSize.width * .5,
             child: PizzaButton(
               size: _pizzaButtonSize,
               presenter: presenter,
             ),
           )
        ],
       
      ),
    );
  }

  @override
  error(Product product) {
    
  }

  @override
  refresh() {
    setState(() {
      
    });
  }
}
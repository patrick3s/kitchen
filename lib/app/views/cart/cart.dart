

import 'package:flutter/material.dart';

import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/cart/widgets/add_item.dart';
import 'package:multidelivery/app/views/cart/widgets/button_resume.dart';
import 'package:multidelivery/app/views/cart/widgets/cart_empty.dart';
import 'package:multidelivery/app/common/delivery.dart';
import 'package:multidelivery/app/views/cart/widgets/info_partner.dart';
import 'package:multidelivery/app/views/cart/widgets/products.dart';
import 'package:multidelivery/app/views/cart/widgets/resume_order.dart';
import 'package:multidelivery/controllers/cart.dart';
import 'package:multidelivery/presenters/cart.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/infra/models/cart.dart';

class Cart extends StatefulWidget {
  const Cart({ Key key }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>  implements CartContract{
  
  Size size;
  CartPresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = CartPresenter(this,CartController(AppModule.to<CartModel>()));
    AppModule.to<Config>().showLog('Cart page iniciada');
    presenter.controller.refresh();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }
  @override
  void dispose() {
    AppModule.to<Config>().showLog('Cart page destruida');
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Carrinho',
              style: TextStyle(
              color: Colors.deepOrange,
              fontSize: size.width * .045
              ),
              ),
              actions: [
                TextButton(onPressed: presenter.cleanCart,
                child: Text('Limpar',
                style: TextStyle(
                  fontSize: size.width * .04,
                  color: Colors.deepOrange
                ),
                ),)
              ],
        elevation: 0,
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: presenter.controller.cartModel.isEmpty,
        builder: (context,value,child) {
          if(value){
            return CartEmpty(
              size: size,
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DeliveryCart(
                      size: size,
                      cartModel: presenter.controller.cartModel,
                      refresh: (){
                        Future.delayed(Duration.zero).then((value) {
                          presenter.controller.cartModel.refreshCart();
                        setState(() {
                          
                        });
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InfoPartner(
                        size: size,
                        presenter: presenter,
                      ),
                    ),
                    ProductsCart(
                      size: size,
                      presenter: presenter,
                    ),
                    AddItem(
                      size: size,
                      presenter: presenter,
                    ),
                    ResumeOrder(
                      size:size,
                      presenter:presenter
                    )
                  ],
                ),
              ),
              ButtonResume(
                size: size,
                presenter: presenter,
              )
            ],
          );
        }
      )
    );
  }

  @override
  refresh() {
    setState(() {
      
    });
  }
}
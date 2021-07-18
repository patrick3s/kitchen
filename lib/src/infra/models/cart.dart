import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class CartModel {
  bool isEmpty = true;
  Order order = Order(products: []);
  ValueNotifier<int> quantityItems = ValueNotifier(0);

  bool addProduct(Product product){
    if(order.partner != null){
      
      if(order.partner.id != product.partnerId){
        return false;
      }
    }else{

      final partners = AppModule.to<BlocPartners>().partners;
      
      if(partners is SuccessPartner){
        final newPartner = partners.list.firstWhere((element) => element.id.trim() == product.partnerId.trim());
        order.partner = Partner.fromMap(newPartner.toMap()..['products']=[]);

        isEmpty = false;
      }
    }
    
    order.products.add(product);

    refreshCart();
    return true;
  }
  clearCart(){
    isEmpty =true;
    quantityItems.value = 0;
    order = Order(products: [],
    formPayment: null
    );
  }
  removeProduct(Product product){
    order.products.remove(product);
    
    if(order.products.isEmpty){
      clearCart();
      return;
    }
    refreshCart();
  }
  refreshCart(){
    quantityItems.value = order.products.length;
    order.subTotalPrice = order.products.map((e) => e.totalPrice()).toList()
    .fold(0, (previousValue, element) => previousValue + element);
    order.totalPrice = order.subTotalPrice + order.partner.deliveryPrice;
  }
}
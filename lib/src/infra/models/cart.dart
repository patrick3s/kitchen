import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class CartModel {
  ValueNotifier<bool> isEmpty = ValueNotifier(true);
  int scheduleIndex = -1;
  Order order = Order(products: [],
  delivery: true,
  scheduleOrder: Order.initSchedule()
  );
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

        isEmpty.value = false;
      }
    }
    
    order.products.add(product);

    refreshCart();
    return true;
  }
  
  clearCart(){
    isEmpty.value =true;
    quantityItems.value = 0;
    scheduleIndex = -1;
    order = Order(products: [],
    formPayment: null,
    delivery: true,
    scheduleOrder: Order.initSchedule()
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
    if(order.products.isEmpty){
      quantityItems.value = order.products.length;
      order.subTotalPrice = 0.0;
      order.totalPrice = 0.0;
    }
    quantityItems.value = order.products.length;
    order.subTotalPrice = order.products.map((e) => e.totalPrice()).toList()
    .fold(0, (previousValue, element) => previousValue + element);
    if(order.partner != null) order.totalPrice = order.subTotalPrice +  (order.delivery  ? order.partner.deliveryPrice : 0.0);
  }
}
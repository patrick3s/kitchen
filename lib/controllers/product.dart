import 'package:flutter/material.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/complement.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductController {
  final GlobalKey<FormFieldState<Product>> formProduct = GlobalKey<FormFieldState<Product>>();
  final Product product;
  final CartModel cart;
  AutoScrollController scrollController;
  ProductController(this.product,this.cart);
  String validator(){
    bool mandatory = false;
    for(var i = 0; i< product.complements.length ; i++){
      if(product.complements[i].mandatory){
        if(product.complements[i].quantity < 1){
          scrollController.scrollToIndex(i,preferPosition: AutoScrollPosition.middle);
          mandatory=true;
          break;
        }
      }
    }
    if(mandatory) return "Preencha os items Obrigatórios";
    return null;
  }

  separateAdditionalByCategory(){
    product.complements.clear();
    Map<String,Complement> mapCategoryAndListAdditional ={};
    for(final additional in product.listAdditional){
      if(!mapCategoryAndListAdditional.containsKey(additional.category)){
        mapCategoryAndListAdditional[additional.category] = Complement(
          additional.category,
          additional.mandatory,
          additional.limit,
          [],
          []
        );
      }
      mapCategoryAndListAdditional[additional.category].additionals.add(additional);
    }
    
    product.complements = mapCategoryAndListAdditional.values.map((e) => e).toList();
  }
}
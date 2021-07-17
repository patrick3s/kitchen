

import 'package:flutter/material.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class PartnerController {
  int indexTab = 0;
  List titlesAndProducts = [];
  Map<String,int> categoryScrollByindex = {};
  final Partner partner;
  final keyHeader = GlobalKey();
  double tabHeight = 0;
  bool tabActivate = false;
  double maxHeightTab;
  final GlobalKey<FormFieldState> form = GlobalKey();
  double minHeightTab = 0;
  AutoScrollController scrollController;
  Map<String,List<Product>> productsByCategory = {};
  PartnerController(this.partner);
  separateProducts(){
    int index = 0;
    categoryScrollByindex.clear();
    titlesAndProducts.clear();
    productsByCategory.clear();
    partner.products.forEach((product) { 
      if(!productsByCategory.containsKey(product.category.title)){
        productsByCategory[product.category.title] =[];
      }
      productsByCategory[product.category.title].add(product);
    });
    if(productsByCategory.isNotEmpty){
      for(Category category  in partner.categories){
      index += productsByCategory[category.title].length ;
      categoryScrollByindex[category.title] = index - productsByCategory[category.title].length;
      titlesAndProducts.add(category);
      for(Product product in productsByCategory[category.title]){
        titlesAndProducts.add(product);
      }
    }
    } 
  }

}


import 'package:flutter/material.dart';
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';
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
  final BlocUsermodel bloc;
  final AuthUser auth;
  PartnerController(this.partner,this.bloc,this.auth);
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

  favoriteParter(){
    final user = UserModel.fromMap(auth.userModel.toMap());
    user.id = auth.user.uid;
    if(user.favorites.contains(partner.id)){
      user.favorites.remove(partner.id);
    }else{
      user.favorites.add(partner.id);
    }
    final state = bloc.update(user);
    if(state is SuccessUserModel){
      auth.userModel = user;
    }
    return state;
  }

  listnerScrollBody(Function refresh){
    final offset = scrollController.offset;
    final renderBox = keyHeader?.currentContext?.findRenderObject() as RenderBox;
    final headerHeight = renderBox?.size?.height ?? 0.0;
    for(int index in categoryScrollByindex.values){
      
      final box = scrollController.tagMap[index+1]?.context?.findRenderObject() as RenderBox;
      final pos = box?.localToGlobal(Offset(0,0));
      final boxOffset = offset -pos.dy;
     // print("$index  posição ${pos.dy} offset $offset boxOffset $boxOffset" );
      
      if( offset < boxOffset){
        form?.currentState?.didChange(index);
        //break;
      }
    }
    if(headerHeight != null){
      if(headerHeight > offset){
        tabHeight = minHeightTab;
      }else{
        tabHeight = maxHeightTab;
      }
    }
    if(offset > 10){
      tabActivate = true;
    }else{
      tabActivate = false;
    }
    refresh();
  }


}
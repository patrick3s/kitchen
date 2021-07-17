

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:multidelivery/src/infra/models/offer.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
enum STATUSCATEGORY { IDLE, SUCCESS ,FAILED, LOADING}
class MainController {
  final AuthUser authUser;
  int categoryIndex = -1;
  List<Category> categories = [];
  List<Partner> partners = [];
  List<Offer> offers = [];
  Timer timer;
  final formPartners = GlobalKey<FormFieldState<int>>();
  final pageControllerOffers = PageController(viewportFraction: .85, initialPage: 0);
  MainController(this.authUser);

  setPartners(List<Partner> list){
    partners.clear();
    partners.addAll(list);
  } 

  setCategory(List<Category> _categories){
    categories.clear();
    categories.addAll(_categories);
  }

  setOffers(List<Offer> offers){
    print(offers);
    offers.clear();
    offers.addAll(offers);
  }

  startAnimationOffers(){
    if(timer != null){
      timer.cancel();
      _createAnimPageOffers();
    }else{
      _createAnimPageOffers();
    }
  }
  _createAnimPageOffers(){
     timer = Timer.periodic(Duration(seconds:7), (timer){
        final page = pageControllerOffers.page.toInt();
   
        if(page == offers.length-1){
          pageControllerOffers.animateToPage(0, duration: Duration(milliseconds: 600), curve: Curves.ease);
        }else{
          pageControllerOffers.nextPage(duration: Duration(milliseconds: 600), curve: Curves.ease);
          }
        
      });
  }
  dispose(){
    timer.cancel();
  }

  List<Partner> getPartners(){
    final index = categoryIndex;
    if(index < 0){
      return partners;
    }
    final _category = categories[index];
    final partnersByCategory = <Partner>[];
    partnersByCategory.addAll(partners);
    partnersByCategory.retainWhere((element) => element.specialtyCategory.title == _category.title);
    return partnersByCategory;
  }
  
  
}
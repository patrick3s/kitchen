import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeNavigator {
  final currentPage = ValueNotifier(0);
  restorePageHome(){
    Modular.to.popUntil(ModalRoute.withName('/'));
  }
  restorePageHomeWithIndexBottomNavigator(String namedPage,int intPage){
    currentPage.value = intPage;
    Modular.to.popUntil(ModalRoute.withName(namedPage));
  }
}
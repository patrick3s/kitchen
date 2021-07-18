

import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/partner_tile.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/partner.dart';

class CustomSearchDelegate extends SearchDelegate {
  
  @override
  List<Widget> buildActions(BuildContext context) {
      
      return [
        IconButton(onPressed: (){
          query = '';
                  }, 
        icon: Icon(IconsPlatform.clear))
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      
      return  IconButton(onPressed: (){
        close(context,null);
      }, icon: Icon(IconsPlatform.back));
    }
  
    @override
    Widget buildResults( BuildContext context) {
      return Center(
        child: Text('Novo',style: TextStyle(color: Colors.black),),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    List<Partner> list = [];
    if(AppModule.to<BlocPartners>().partners is SuccessPartner){
      list.addAll((AppModule.to<BlocPartners>().partners as SuccessPartner).list);
      list.retainWhere((element) => element.name.toUpperCase().startsWith(query.toUpperCase()));
    }
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index){
      return PartnerTile(
        partner: list[index],
        size: size,
      );
    });
  }
}
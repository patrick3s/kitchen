import 'package:flutter/material.dart';
import 'package:multidelivery/shared/icons_platform.dart';

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
    
    return Column();
  }
}
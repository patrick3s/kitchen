import 'package:flutter/material.dart';
import 'package:multidelivery/controllers/partner.dart';


abstract class PartnerContract {
  refresh();
}

class PartnerPresenter {
  final PartnerContract _contract;
  final PartnerController controller;

  PartnerPresenter(this._contract, this.controller);

  listnerScrollBody(){
    final offset = controller.scrollController.offset;
    final renderBox = controller.keyHeader?.currentContext?.findRenderObject() as RenderBox;
    final headerHeight = renderBox?.size?.height ?? 0.0;
    for(int index in controller.categoryScrollByindex.values){
      
      final box = controller.scrollController.tagMap[index+1]?.context?.findRenderObject() as RenderBox;
      final pos = box?.localToGlobal(Offset(0,0));
      final boxOffset = offset -pos.dy;
     // print("$index  posição ${pos.dy} offset $offset boxOffset $boxOffset" );
      
      if( offset < boxOffset){
        controller?.form?.currentState?.didChange(index);
        //break;
      }
    }
    if(headerHeight != null){
      if(headerHeight > offset){
        controller.tabHeight = controller.minHeightTab;
      }else{
        controller.tabHeight = controller.maxHeightTab;
      }
    }
    if(offset > 10){
      controller.tabActivate = true;
    }else{
      controller.tabActivate = false;
    }
    _contract.refresh();
  }
}
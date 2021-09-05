import 'package:flutter/material.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/utils/models.dart';

class ScheduleController {
  final CartModel cart;
  final Partner partner;
  final form = GlobalKey<FormFieldState<int>>();
  ScheduleController(this.cart,this.partner);
  checkDate(DateTime date){
    final today = DateTime.now();
    
    if(date.day == today.day){
      cart.scheduleIndex = -1;
      
    cart.order.scheduleOrder.title = "Hoje";  
    }else{
          cart.scheduleIndex = 0;
          cart.order.scheduleOrder.title = "${weekdayList[date.weekday -1]}. ${date.day}/${monthList[date.month -1]}";
    }
    form..currentState.didChange(cart.scheduleIndex);
    return true;
  }

  selectHour(){
    if(cart.scheduleIndex >= 0){
      cart.order.scheduleOrder.selectHour = partner.scheduleOrder.intervals[cart.scheduleIndex];
    }
  }
  dateMax() {
    final today = DateTime.now();
    if (today.month < 11) {
      return DateTime(today.year, today.month + 1, 1);
    }
    return DateTime(today.year + 1, 1, 1);
  }


}
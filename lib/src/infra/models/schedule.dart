import 'dart:convert';

import 'package:flutter/material.dart';

class ScheduleIntervalByDay {
  final TimeOfDay initialHour;
  final TimeOfDay finalHour;

  ScheduleIntervalByDay({this.initialHour, this.finalHour});

  Map<String, dynamic> toMap() {
    return {
      'initialHour': initialHour.hour.toString() +':'+initialHour.minute.toString(),
      'finalHour': finalHour.hour.toString() + ":"+finalHour.minute.toString(),
    };
  }

  factory ScheduleIntervalByDay.fromMap(Map<String, dynamic> map) {
    return ScheduleIntervalByDay(
      initialHour: TimeOfDay( hour:int.parse(map['initialHour'].split(':')[0]),minute:int.parse(map['initialHour'].split(':')[1]) ),
      finalHour: TimeOfDay(hour: int.parse(map['finalHour'].split(':')[0]),minute: int.parse(map['finalHour'].split(':')[1])),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleIntervalByDay.fromJson(String source) => ScheduleIntervalByDay.fromMap(json.decode(source));
  
  formatString(){
    var initial = (initialHour.hour < 10 ? "0${initialHour.hour}":initialHour.hour.toString()) +':';
    initial += initialHour.minute < 10 ?"0${initialHour.minute}":"${initialHour.minute}";
    var finalH = (finalHour.hour < 10 ? "0${finalHour.hour}":finalHour.hour.toString()) +':';
    finalH += finalHour.minute < 10 ?"0${finalHour.minute}":"${finalHour.minute}";
    return "$initial ás $finalH";
  }
}

class ScheduleOrder {
   String title;
   List<int> days;
   ScheduleIntervalByDay selectHour;
   List<ScheduleIntervalByDay> intervals;
  ScheduleOrder({this.title, this.days, this.intervals,this.selectHour});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'days': days,
      'selectHour':selectHour?.toMap(),
      'intervals': intervals?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ScheduleOrder.fromMap(Map<String, dynamic> map) {
    return ScheduleOrder(
      title: map['title'],
      days: List<int>.from(map['days']),
      selectHour:  map['selectHour'] != null ? ScheduleIntervalByDay.fromMap(map['selectHour']) : null,
     intervals: List<ScheduleIntervalByDay>.from(map['intervals']?.map((x) => ScheduleIntervalByDay.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleOrder.fromJson(String source) => ScheduleOrder.fromMap(json.decode(source));
  
  
}

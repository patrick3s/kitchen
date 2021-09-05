import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconsPlatform {
  static IconData notificationBorder = Platform.isAndroid ? Icons.notifications_none : CupertinoIcons.bell;
  static IconData notification = Platform.isAndroid ? Icons.notifications : CupertinoIcons.bell_fill;
  static IconData home = Platform.isAndroid ? Icons.home : CupertinoIcons.house_fill;
  static IconData person = Platform.isAndroid ? Icons.person : CupertinoIcons.person_fill;
  static IconData orders = Platform.isAndroid ? Icons.article_rounded : CupertinoIcons.doc_text_fill;
  static IconData back = Platform.isAndroid ? Icons.arrow_back : CupertinoIcons.back;
  static IconData checkmark = Platform.isAndroid ? Icons.assignment_turned_in_rounded : CupertinoIcons.checkmark_seal_fill;
  static IconData lock = Platform.isAndroid ? Icons.lock : CupertinoIcons.lock_fill;
  static IconData lockOpen = Platform.isAndroid ? Icons.lock_open : CupertinoIcons.lock_open_fill;
  static IconData down = Platform.isAndroid ? Icons.arrow_drop_down : CupertinoIcons.arrowtriangle_down;
  static IconData email = Platform.isAndroid ? Icons.email : CupertinoIcons.mail;
  static IconData cart = Platform.isAndroid ? Icons.shopping_cart : CupertinoIcons.cart;
  static IconData editLocation = Platform.isAndroid ? Icons.edit_location : CupertinoIcons.location_circle_fill;
  static IconData editLocationBorder = Platform.isAndroid ? Icons.edit_location_outlined : CupertinoIcons.location_circle;
  static IconData search = Platform.isAndroid ? Icons.search : CupertinoIcons.search;
  static IconData favorite = Platform.isAndroid ? Icons.favorite : CupertinoIcons.heart_fill;
  static IconData favoriteBorder = Platform.isAndroid ? Icons.favorite_outline : CupertinoIcons.heart;
  static IconData clear = Platform.isAndroid ? Icons.clear : CupertinoIcons.clear;
  static IconData star = Platform.isAndroid ? Icons.star : CupertinoIcons.star_fill;
  static IconData connection = Platform.isAndroid ? Icons.cell_wifi_sharp : CupertinoIcons.antenna_radiowaves_left_right;
  static IconData reset = Platform.isAndroid ? Icons.sync_alt_sharp : CupertinoIcons.gobackward;
  static IconData starHalf = Platform.isAndroid ? Icons.star_half : CupertinoIcons.star_lefthalf_fill;
  static IconData starBorder = Platform.isAndroid ? Icons.star_border : CupertinoIcons.star;
  static IconData add = Platform.isAndroid ? Icons.add : CupertinoIcons.add;
  static IconData remove = Platform.isAndroid ? Icons.remove : CupertinoIcons.minus;
  static IconData chat = Platform.isAndroid ? Icons.comment_outlined :CupertinoIcons.chat_bubble_text;
  static IconData credit = Platform.isAndroid ? Icons.credit_card : CupertinoIcons.creditcard;
  static IconData money = Platform.isAndroid ? Icons.attach_money : CupertinoIcons.money_dollar;
  static IconData delete = Platform.isAndroid ? Icons.delete : CupertinoIcons.delete;
  static IconData arrowForward = Platform.isAndroid ? Icons.arrow_forward_ios : CupertinoIcons.chevron_forward;
  static IconData arrowBack = Platform.isAndroid ? Icons.arrow_back_ios : CupertinoIcons.chevron_back;
  static IconData exit = Platform.isAndroid ? Icons.exit_to_app : CupertinoIcons.power;
  static IconData coupons = Platform.isAndroid ? Icons.card_giftcard_rounded : CupertinoIcons.tickets;
  static IconData taskVerified = Platform.isAndroid ? Icons.task_alt_outlined : CupertinoIcons.checkmark_seal;
}
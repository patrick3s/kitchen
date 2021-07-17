
import 'package:multidelivery/controllers/page_main.dart';

abstract class MainContract {}

class MainPresenter {
  final MainContract contract;
  final MainController controller;
  MainPresenter(this.contract, this.controller);

}
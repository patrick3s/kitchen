import 'package:multidelivery/controllers/schedule.dart';

abstract class ScheduleContract {
  refresh();
  notification(String text);
  Future<dynamic> showDate();
}

class SchedulePresenter {
  final ScheduleContract _contract;
  final ScheduleController controller;

  SchedulePresenter(this._contract, this.controller);

  dateAvaible() async{
    final date = await _contract.showDate();
    if(date == null) return;
    final check = controller.checkDate(date);
    if(!check){
      _contract.notification('Você só pode agendar com no máximo um dia de antecedencia');
      return;
    }
    _contract.refresh();
  }

  selectHour(){}
  

}
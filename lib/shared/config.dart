import 'package:connection_verify/connection_verify.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class Config {
  bool log = true;
  void showLog(String logText){
    if(log){
      print(logText);
    }
  }
  Future<bool> isConnection()async{
   if (await ConnectionVerify.connectionStatus()){
      print("Você está conectado");
      return true;
    } else {
      print("Você não está conectado");
      notificationPopup('Ops!',"Desculpe você não está conectado, tente novamente mais tarde");
      return false;
      //Do your offline stuff here
    }
  }
}
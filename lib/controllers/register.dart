import 'package:multidelivery/resources/city.dart';
import 'package:multidelivery/resources/states.dart';

class ControllerRegister {
  static List<Map> getCityByIdUf(String idUf) {
    if (idUf == null) return [];
    List<Map> copyCities = [];
    copyCities.addAll(cities);
    copyCities.retainWhere((element) => element["Estado"] == idUf);
    return copyCities;
  }

  static Map getUfById(String idUf) {
    int index = int.parse(idUf);
    Map nameState = state[index - 1];
    return nameState;
  }
}

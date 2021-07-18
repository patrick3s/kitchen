import 'package:multidelivery/blocs/address.dart';
import 'package:multidelivery/resources/city.dart';
import 'package:multidelivery/resources/states.dart';



class AddAdressController {
  final BlocAddress bloc;
  Map<String,dynamic> address = {};
  AddAdressController( this.bloc);

  Future<AddressState> saveAddress()async{
    return await bloc.create(address);
  }
   List<Map> getCityByIdUf(String idUf) {
    if (idUf == null) return [];
    List<Map> copyCities = [];
    copyCities.addAll(cities);
    copyCities.retainWhere((element) => element["Estado"] == idUf);
    return copyCities;
  }

   Map getUfById(String idUf) {
    int index = int.parse(idUf);
    Map nameState = state[index - 1];
    return nameState;
  }
}
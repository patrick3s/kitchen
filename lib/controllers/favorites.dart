import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/partner.dart';

class FavoritesController {
  final BlocPartners bloc;
  final AuthUser auth;
  List<Partner> partners = [];
  FavoritesController(this.bloc, this.auth){
    _separateFavorites();
  }

  _separateFavorites(){
    partners.clear();
    if(bloc.partners is SuccessPartner){
      partners.addAll((bloc.partners as SuccessPartner).list);
    }
    partners.retainWhere((partner) => auth.userModel.favorites.contains(partner.id));
  }
}
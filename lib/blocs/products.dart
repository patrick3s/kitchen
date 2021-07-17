import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/domain/usecase/product.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:rxdart/subjects.dart';

abstract class ProductState {}

class LoadingProduct extends ProductState {}
class SuccessProduct extends ProductState {
final List<Product> list;
  SuccessProduct(this.list);
}
class ErrorProduct extends ProductState {
  final Failure fail;
  ErrorProduct(this.fail);
}
class IdleProduct extends ProductState {}

class BlocProducts {
  final AuthUser auth;
  final Partner partner;
  final UsecaseProduct usecaseProduct;
  final BehaviorSubject<ProductState> _controller = BehaviorSubject.seeded(IdleProduct());
  BlocProducts(this.auth,this.partner,this.usecaseProduct){
    if(partner.products.isEmpty){
      load();
    }
  }
  Stream<ProductState> get stream => _controller.stream;
  load()async{
    AppModule.to<Config>().showLog('Buscando produtos');
    _controller.add(LoadingProduct());
    final result = await usecaseProduct.call(partner);
    result.fold((l) {
      _controller.add(SuccessProduct(l));
      partner.products = l;
    }, (r) {
      _controller.add(ErrorProduct(r));
    });
  }
  dispose(){
    _controller.close();
  }
}
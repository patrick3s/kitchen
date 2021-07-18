import 'package:multidelivery/src/domain/usecase/address.dart';
import 'package:multidelivery/src/domain/usecase/category.dart';
import 'package:multidelivery/src/domain/usecase/evaluation.dart';
import 'package:multidelivery/src/domain/usecase/offers.dart';
import 'package:multidelivery/src/domain/usecase/orders.dart';
import 'package:multidelivery/src/domain/usecase/partners.dart';
import 'package:multidelivery/src/domain/usecase/product.dart';
import 'package:multidelivery/src/domain/usecase/usermodel.dart';

abstract class Core{
  UsecasePartner usecasePartners();
UsecaseOffers usecaseOffers();
 UsecaseCategory usecaseCategory();   
   UsecaseProduct usecaseProduct(); 
 UsecaseEvaluation usecaseEvaluation();
  UsecaseOrders useCaseOrdersImpl();
  UsecaseUserModel usecaseUserModel();
  UsecaseAddress usecaseAddress();
}

class CoreImpl extends Core{
  final Core core;

  CoreImpl(this.core);
  @override
  UsecaseOrders useCaseOrdersImpl() {
    return core.useCaseOrdersImpl();
  }

  @override
  UsecaseCategory usecaseCategory() {
    return core.usecaseCategory();
  }

  @override
  UsecaseEvaluation usecaseEvaluation() {
    return core.usecaseEvaluation();
  }

  @override
  UsecaseOffers usecaseOffers() {
    return core.usecaseOffers();
  }

  @override
  UsecasePartner usecasePartners() {
    return core.usecasePartners();
  }

  @override
  UsecaseProduct usecaseProduct() {
    return core.usecaseProduct();
  }

  @override
  UsecaseUserModel usecaseUserModel() {
    return core.usecaseUserModel();
  }

  @override
  UsecaseAddress usecaseAddress() {
    return core.usecaseAddress();
  }


}
import 'package:multidelivery/src/domain/usecase/address.dart';
import 'package:multidelivery/src/domain/usecase/category.dart';
import 'package:multidelivery/src/domain/usecase/evaluation.dart';
import 'package:multidelivery/src/domain/usecase/offers.dart';
import 'package:multidelivery/src/domain/usecase/orders.dart';
import 'package:multidelivery/src/domain/usecase/partners.dart';
import 'package:multidelivery/src/domain/usecase/product.dart';
import 'package:multidelivery/src/domain/usecase/usermodel.dart';
import 'package:multidelivery/src/externals/core.dart';
import 'package:multidelivery/src/externals/firebase/address.dart';
import 'package:multidelivery/src/externals/firebase/category.dart';
import 'package:multidelivery/src/externals/firebase/evaluation.dart';
import 'package:multidelivery/src/externals/firebase/offers.dart';
import 'package:multidelivery/src/externals/firebase/order.dart';
import 'package:multidelivery/src/externals/firebase/partners.dart';
import 'package:multidelivery/src/externals/firebase/product.dart';
import 'package:multidelivery/src/externals/firebase/usermodel.dart';
import 'package:multidelivery/src/infra/repositories/address.dart';
import 'package:multidelivery/src/infra/repositories/category.dart';
import 'package:multidelivery/src/infra/repositories/evaluation.dart';
import 'package:multidelivery/src/infra/repositories/offers.dart';
import 'package:multidelivery/src/infra/repositories/orders.dart';
import 'package:multidelivery/src/infra/repositories/partners.dart';
import 'package:multidelivery/src/infra/repositories/product.dart';
import 'package:multidelivery/src/infra/repositories/usermodel.dart';

class CoreFirebase extends Core {
  @override
  usecasePartners() {
    final datasource = FirebasePartners();
    final repository = RepositoryPartnersImpl(datasource);
    return UsecasePartnerImple(repository);
  }
  @override
  usecaseOffers() {
    final datasource = FirebaseOffers();
    final repository = RepositoryOffersImpl(datasource);
    return UsecaseOffersImpl(repository);
  }
  @override
  usecaseCategory() {
    final datasource = FirebaseCategory();
    final repository = RepositoryCategoryImpl(datasource);
    return UsecaseCategoryImpl(repository);
  }
  @override
  usecaseProduct() {
    final datasource = FirebaseProduct();
    final repository = RepositoryProductImpl(datasource);
    return UsecaseProductImpl(repository);
  }
  @override
  usecaseEvaluation() {
    final datasource = FirebaseEvaluation();
    final repository = RepositoryEvaluationImpl(datasource);
    return UsecaseEvaluationImpl(repository);
  }
  @override
  useCaseOrdersImpl() {
    final datasource = FirebaseOrder();
    final repository = RepositoryOrderImple(datasource);
    return UseCaseOrdersImpl(repository);
  }

  @override
  UsecaseUserModel usecaseUserModel() {
    final datasource = FirebaseUserModel();
    final repository = RepositoryUserModelImpl(datasource);
    return UsecaseUserModelImpl(repository);
  }

  @override
  UsecaseAddress usecaseAddress() {
    final datasource = FirebaseAddress();
    final repository = RepositoryAddressImple(datasource);
    return UsecaseAddressImpl(repository);
  }
  
}


import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_widget.dart';
import 'package:multidelivery/app/views/add_address/add_address.dart';
import 'package:multidelivery/app/views/address/address.dart';
import 'package:multidelivery/app/views/cart/cart.dart';
import 'package:multidelivery/app/views/cart_confirmation/cart_confirmation.dart';
import 'package:multidelivery/app/views/edit_profile/edit_profile.dart';
import 'package:multidelivery/app/views/evaluation/evaluation.dart';
import 'package:multidelivery/app/views/favorites/favorites.dart';
import 'package:multidelivery/app/views/order/order.dart';
import 'package:multidelivery/app/views/partner_evaluation/partner_evaluation.dart';
import 'package:multidelivery/app/views/product/product.dart';
import 'package:multidelivery/app/views/schedule/schedule.dart';
import 'package:multidelivery/app/views/webview/webview.dart';
import 'package:multidelivery/blocs/offers.dart';
import 'package:multidelivery/blocs/orders.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/resources/fcm.dart';
import 'package:multidelivery/shared/home_navigator.dart';
import 'package:multidelivery/app/views/partner/partner.dart';
import 'package:multidelivery/app/views/sign_in/sign_in.dart';
import 'package:multidelivery/app/views/sign_up/sign_up.dart';
import 'package:multidelivery/app/views/splash/splash.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/externals/core.dart';
import 'package:multidelivery/src/externals/core/firebase.dart';
import 'package:multidelivery/src/infra/models/cart.dart';

// ignore: must_be_immutable
class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => CoreImpl(CoreFirebase())),
    Bind((i) => Config()),
    Bind((i) => FcmResource(i<Config>())),    
    Bind((i) =>HomeNavigator()),
    Bind((i) => CartModel()),
    Bind((i) => AuthUser(i<Config>())),
    Bind((i) => BlocPartners(i<AuthUser>(), i<CoreImpl>().usecasePartners())),
    Bind((i) => BlocOrder(i<CoreImpl>().useCaseOrdersImpl(),i<AuthUser>())),
    Bind((i) => BlocUsermodel(i<AuthUser>(),i<CoreImpl>().usecaseUserModel())),
    Bind((i) => BlocOffers(i<AuthUser>(),
    i<CoreImpl>().usecaseOffers()))
  ];
  @override 
  List<ModularRouter> routers = [
    ModularRouter('/',child:(_,args) => Splash()),
    ModularRouter('/signin', child:(_,args) => SignIn()),
    ModularRouter('/signup', child: (_,args) => SignUp()),
    ModularRouter('/partner', child: (_,args) => Partner(partner: args.data,)),
    ModularRouter('/cart',child: (_,args) => Cart()),
    ModularRouter('/cart_confirmation', child: (_,args) => CartConfirmation()),
    ModularRouter('/partner_evaluation',child: (_,args) => PartnerEvaluation(partner: args.data,)),
    ModularRouter('/product',child: (_,args) => ProductDetail(product: args.data,)),
    ModularRouter('/webview',child:(_,args) => WebViewPage()),
    ModularRouter('/order',child: (_,args) => OrderView(map:args.data)),
    ModularRouter('/evaluation',child:(_,args) => EvaluationView(order: args.data,)),
    ModularRouter('/favorites',child:(_,args) => Favorites()),
    ModularRouter('/address',child: (_,args) => AddressView()),
    ModularRouter('/add_address',child: (_,args) => AddAddress()),
    ModularRouter('/edit_profile',child: (_,args) => EditProfile()),
    ModularRouter('/schedule',child:(_,args) => ScheduleView(partner: args.data,))
  ];
  static Inject get to => Inject<AppModule>();

  @override
  
  Widget get bootstrap => DevicePreview(
    enabled: !kReleaseMode,
    builder: (_) => AppWidget(),
  );

  

}
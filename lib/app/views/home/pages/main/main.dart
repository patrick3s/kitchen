
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/home/pages/main/widgets/partners.dart';
import 'package:multidelivery/blocs/category.dart';
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/controllers/page_main.dart';
import 'package:multidelivery/presenters/page_main.dart';
import 'package:multidelivery/app/views/home/pages/main/widgets/offers.dart';
import 'package:multidelivery/app/views/home/pages/main/widgets/tabs_main.dart';
import 'package:multidelivery/blocs/offers.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/externals/core.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Main extends StatefulWidget {
  const Main({ Key key }) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> implements MainContract  {
  MainPresenter presenter;
  final styleText = TextStyle();
  Size size;
  BlocPartners _blocPartners;
  BlocOffers _blocOffers;
  double tabHeigth;
  BlocCategory _blocCategory;
  AutoScrollController controller;
  @override
  void initState() {
    super.initState();
    _blocPartners = AppModule.to<BlocPartners>();
    _blocOffers = AppModule.to<BlocOffers>();
    _blocCategory = BlocCategory(AppModule.to<CoreImpl>().usecaseCategory());
    presenter = MainPresenter(
      this,
      MainController(AppModule.to<AuthUser>())
    );
    AppModule.to<Config>().showLog('Main Page iniciada');
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('Main Page destruida');
    


    _blocCategory.dispose();
    super.dispose();
    presenter.controller.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    controller =AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            _appBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  if(await AppModule.to<Config>().isConnection() == false)return;
                  await _blocCategory.load();
                  await _blocOffers.loadOffer();
                  await _blocPartners.searchPartners();
                },
                child: ListView(
                  children: [

                    TabsMain(
                      styleText: styleText,
                      presenter: presenter,
                      bloc: _blocCategory,
                      controller: controller,
                      size: size,
                    ),
                    Offers(blocOffers: _blocOffers,size: size,presenter: presenter,),
                    Partners(
                      blocPartners: _blocPartners,
                      presenter: presenter,
                      size: size,
                    )
                  ],
                ),
              ),
            )
          ],
      ),
        ),),
    );
  }

  _appBar(){
    final height =AppBar().preferredSize.height;
    return Container(
      width: double.infinity,
      child: StreamBuilder<UserModelState>(
        stream: AppModule.to<BlocUsermodel>().stream,
        builder: (context, snapshot) {
          if(snapshot.data is LoadingUserModel){
            return Center(
              child: SpinKitThreeBounce(color: Colors.deepOrange,
              size: size.width * .05
              ),
            );
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Modular.to.pushNamed('address');
                    },
                    child: Icon(IconsPlatform.editLocation,
                    color: Colors.black,
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:35.0),
                    child: LayoutBuilder(
                      builder: (context, constrains) {
                        return InkWell(
                          onTap: (){
                            Modular.to.pushNamed('address');
                          },
                          child: Container(
                            height: height,
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 15),
                            width: constrains.maxWidth,
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "${presenter.controller.authUser.userModel.address['city']}-${presenter.controller.authUser.userModel.address['uf']}",
                            style: styleText.copyWith(
                              fontSize: size.width * .05,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                          ),
                        );
                      }
                    ),
                  )),
                  InkWell(
                    onTap: (){
                      Modular.to.pushNamed('favorites');
                    },
                    child: Icon(IconsPlatform.favorite))
                ],
              ),
          
            ],
          );
        }
      ),
    );
  }

  
  
}
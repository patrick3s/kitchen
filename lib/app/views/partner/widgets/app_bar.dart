import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/presenters/partner.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:transparent_image/transparent_image.dart';

class AppBarPartner extends StatelessWidget {
  final PartnerPresenter presenter;
  final Size size;
  final height = AppBar().preferredSize.height * 2;
  AppBarPartner({Key key, this.presenter, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          _appBarWithoutBackground(),
          _appBarBackground(),
          _buttons()
        ],
      ),
    );
  }

  _appBarBackground() {
    return AnimatedOpacity(
      opacity: presenter.controller.tabActivate ? 0 : 1,
      duration: Duration(seconds: 1),
      child: Container(
        height:height ,
        width: double.infinity,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: presenter.controller.partner.backgroundImg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _appBarWithoutBackground() {
    return AnimatedOpacity(
      opacity: presenter.controller.tabActivate ? 1 : 0,
      duration: Duration(seconds:1),
      child: Container(
        height: height,
        padding: EdgeInsets.only(top:height*.27),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              presenter.controller.partner.name,
              maxLines: 1,
              style: TextStyle(fontSize: AppBar().preferredSize.height * .44, color: Colors.black),
            ),
            Text(
              "Entrega em ${presenter.controller.partner.deliveryTime}",
              style: TextStyle(fontSize: AppBar().preferredSize.height * .25, color: Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }
   _buttons(){
      return Container(
        height: height,
        width: double.infinity,
        padding: EdgeInsets.only(top:height*.27),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(360))),
              child: IconButton(onPressed: (){
                Modular.to.pop();
              }, icon: Icon(IconsPlatform.back)),
            ),
            AnimatedOpacity(
              opacity: presenter.controller.tabActivate ? 1 : 0,
              duration: Duration(seconds:1),
              child: IgnorePointer(
                ignoring: !presenter.controller.tabActivate,
                child: StreamBuilder<UserModelState>(
                  stream: AppModule.to<BlocUsermodel>().stream,
                  builder: (context, snapshot) {
                    if(snapshot.data is LoadingUserModel){
                      return Center(
                        child: SpinKitThreeBounce(color: Colors.deepOrange,
                        size: 26,
                        ),
                      );
                    }
                    return IconButton(onPressed: presenter.favorite,
                     icon: Icon(Icons.favorite,
                    color: presenter.controller.auth.userModel.favorites
                    .contains(presenter.controller.partner.id) ? Colors.deepOrange : Colors.grey,
                    ));
                  }
                )),
            )
          ],
        ),
      );
    }
}

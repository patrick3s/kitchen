import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/utils/common_widgets.dart';

import '../../../../app_module.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Size size;
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Profile Page iniciada');
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    super.dispose();
    AppModule.to<Config>().showLog('Profile Page destruida');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _profile(),
            _row(IconsPlatform.chat, "Chats", "", null),
            _row(IconsPlatform.coupons, "Cupons", "Cupons de desconto", null),
            _row(IconsPlatform.notificationBorder, "Notificações", "",null),
            _row(IconsPlatform.taskVerified, 'Fidelidade', 'Promoções de fidelização com parceiros', null),
            _row(IconsPlatform.editLocationBorder, "Endereços", "Meus endereços", (){
              Modular.to.pushNamed('address');
            }),
            _row(IconsPlatform.favoriteBorder,'Favoritos','',(){
              Modular.to.pushNamed('favorites');
            }),
            _row(IconsPlatform.exit, 'Sair', '', () {
              AppModule.to<AuthUser>().signout();
            })
          ],
        ),
      ),
    );
  }

  _profile() {
    return Container(
      height: size.height * .1,
      width: size.width,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(.5)))),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          CircleAvatar(
            radius: size.height * .03,
            backgroundColor: Colors.black12,
            child: Icon(
              IconsPlatform.person,
              color: Colors.black,
              size: size.width * .055,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppModule.to<AuthUser>().userModel.name,
                style: TextStyle(fontSize: size.width * .045),
              ),
              SizedBox(height: 3),
              Text(
                'Edite seu perfil',
                style:
                    TextStyle(fontSize: size.width * .035, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  _row(IconData icon, String title, String subtitle, Function onTap) {
    return InkWell(
      onTap: onTap ??
          () {
            notificationPopup(title, 'Em breve !!!');
          },
      child: Container(
        height: size.height * .085,
        width: size.width,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey.withOpacity(.5)))),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: size.width * 0.05,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: size.width * .045),
                  ),
                  subtitle.isEmpty
                      ? Container()
                      : Column(children: [
                          SizedBox(height: 3),
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: size.width * .035,
                                color: Colors.grey),
                          )
                        ])
                ],
              ),
            ),
            Icon(IconsPlatform.arrowForward,
                color: Colors.grey, size: size.width * .04)
          ],
        ),
      ),
    );
  }
}

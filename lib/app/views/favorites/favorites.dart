

import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/partner_tile.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/controllers/favorites.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';

class Favorites extends StatefulWidget {
  const Favorites({ Key key }) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  FavoritesController controller;
  Size size;
  @override
  void initState() {
    AppModule.to<Config>().showLog('Favorites iniciado');
    super.initState();
    controller = FavoritesController(AppModule.to<BlocPartners>()
    ,AppModule.to<AuthUser>());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('Favorites destruido');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Favoritos',
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * .045
        ),
        ),
      ),
      body: 
      controller.partners.isEmpty ? Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Image.asset('assets/comercio.png',
                fit: BoxFit.cover,
                ),
              )),
            Expanded(child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('Você não tem nenhum parceiro favoritado ainda.',
                    style: TextStyle(
                      fontSize: size.width * .045,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange
                    ),
                    )
                  ]
                ),
              ),
            ))
          ],
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ...controller.partners.map((e) => PartnerTile(
              partner: e,
              size: size,
            )).toList()
          ],
        ),
      ),
    );
  }

}
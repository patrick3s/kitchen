

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/error.dart';
import 'package:multidelivery/blocs/offers.dart';
import 'package:multidelivery/blocs/partners.dart';
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/controllers/address.dart';
import 'package:multidelivery/presenters/address.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/home_navigator.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class AddressView extends StatefulWidget {
  const AddressView({ Key key }) : super(key: key);

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> implements AddressContract {
  
  Size size;
  AddressPresenter presenter;
  @override
  initState(){
    super.initState();
    AppModule.to<Config>().showLog('Address iniciado');
    presenter = AddressPresenter(this,AddressController(
      AppModule.to<BlocUsermodel>(),
      AppModule.to<AuthUser>()
    ));
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('Address iniciado');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: (){
          Modular.to.pushNamed('add_address');
        },
        child: Icon(IconsPlatform.add),),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text('Meus endereços',
        style: TextStyle(
          fontSize: size.width * .045,
          color: Colors.black
        )),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('users')
          .doc(presenter.controller.auth.user.uid).collection('address').snapshots(),
          builder: (context, snapshot) {
            final loading = Center(
                  child: SpinKitThreeBounce(size: 26,
                  color: Colors.deepOrange,),
                );
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return loading;
                break;
              default:
              break;
            }
            if(snapshot.hasError){
              return ErrorView();
            }
            return StreamBuilder<UserModelState>(
              stream: presenter.controller.bloc.stream,
              builder: (context, snapshotUser) {
                if(snapshot.data is LoadingUserModel){
                  return loading;
                }
                if(snapshot.data.docs.isEmpty){
                  return Center(
                    child: SpinKitThreeBounce(
                      color: Colors.deepOrange,
                      size: 26,
                      ),
                  );
                }
                return ListView(
                  children: [
                    ...snapshot.data.docs.map((e) => _card(e)).toList()                      
                  ],
                );
              }
            );
          }
        ),
      );
  }

  _card(QueryDocumentSnapshot<Map<String,dynamic>> address){
    return InkWell(
      onTap: (){
        presenter.selectAddress(address.data());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(IconsPlatform.editLocation,
                          size: size.width * .05,
                          ),
                          SizedBox(width:10),
                          Text('Endereço',
                          style: TextStyle(
                            fontSize: size.width * .06,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${address.data()['street']},${address.data()['numberHome']}",
                      style: TextStyle(
                        fontSize: size.width * .045
                      ),
                      ),
                      Text("Ref:${address.data()['reference']}",
                      style: TextStyle(
                        fontSize: size.width * .045
                      ),
                      ),
                      Text("${address.data()['city']},${address.data()['uf']}",
                      style: TextStyle(
                        fontSize: size.width * .045
                      ),
                      )
                    ],
                  ),
                  Center(
                    child: IconButton(onPressed: (){},
                     icon: Icon(IconsPlatform.delete,
                     size: size.width * .05,
                     color: Colors.red,
                     )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  notification(String text) {
    notificationPopup('Atenção', text);
  }

  @override
  success() {
    AppModule.to<HomeNavigator>().restorePageHomeWithIndexBottomNavigator('/', 0);
    AppModule.to<BlocPartners>().searchPartners();
    AppModule.to<BlocOffers>().loadOffer();
    setState(() {
      
    });
  }
}
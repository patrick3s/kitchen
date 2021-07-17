import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/views/error/error.dart';
import 'package:multidelivery/app/views/home/pages/orders/widgets/appbar.dart';
import 'package:multidelivery/app/views/home/pages/orders/widgets/order_tile.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import '../../../../app_module.dart';

class Orders extends StatefulWidget {
  const Orders({ Key key }) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Size size;
  
  @override
  void initState() {
    super.initState();
    
    
    AppModule.to<Config>().showLog('Orders Page iniciada');
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }
  @override
  void dispose() {
    super.dispose();
    
    AppModule.to<Config>().showLog('Orders Page destruida');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').doc(AppModule.to<AuthUser>().user.uid)
        .collection('orders').orderBy('createAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            return Center(
              child: SpinKitThreeBounce(
                size: 26,
                color: Colors.deepOrange,
              ),
            );
            break;
            default:
            break;
          }
          if(snapshot.hasError){
            return ErrorView();
          }
          if(snapshot.data.docs.isEmpty){
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/pedido_vaio.gif',
                  fit: BoxFit.cover,
                  )),
                  Expanded(child: Container(
                    child: Column(
                      children:[
                        Text('Você ainda não fez nenhum pedido',
                        style: TextStyle(
                          fontSize: size.width * .05,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                         Text('Corra e faça o seu, é rapidinho.',
                        style: TextStyle(
                          fontSize: size.width * .04,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold
                        ),
                        )
                      ]
                    ),
                  ))
              ],
            );
          }

          return Column(
            children: [
              AppBarOrders(),
              Expanded(
                child: ListView(
                  children: [
                    ...snapshot.data.docs.map((e) => OrderTile(doc :e.data())).toList()
                  ],
                ),
              ),
            ],
          );
        }
      )),
    );
  }
}
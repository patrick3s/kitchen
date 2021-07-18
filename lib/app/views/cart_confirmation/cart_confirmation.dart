



import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/show_modal.dart';
import 'package:multidelivery/app/views/cart_confirmation/widgets/confirmation.dart';
import 'package:multidelivery/blocs/orders.dart';
import 'package:multidelivery/controllers/cart_confirmation.dart';
import 'package:multidelivery/presenters/cart_confirmation.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/home_navigator.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:multidelivery/src/infra/models/payment.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class CartConfirmation extends StatefulWidget {
  const CartConfirmation({ Key key }) : super(key: key);

  @override
  _CartConfirmationState createState() => _CartConfirmationState();
}

class _CartConfirmationState extends State<CartConfirmation> implements CartConfirmationContract {
  Size size;
  
  CartConfirmationPresenter presenter;
  @override
  void initState() {

    AppModule.to<Config>().showLog('CartConfirmation iniciado');
    presenter = CartConfirmationPresenter(
      this,
      CartConfirmationController(AppModule.to<CartModel>(),AppModule.to<AuthUser>(),AppModule.to<BlocOrder>())
    );
    super.initState();
  }
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('CartConfirmation destruido');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text("Confirmar pedido",
        style: TextStyle(
          fontSize: size.width * .05,
          color: Colors.deepOrange
        ),
        ),
      ),
      body: FormField<FormPayment>(
        initialValue: presenter.controller.cart.order.formPayment,
        builder: (state) {
          presenter.controller.cart.order.formPayment = state.value;
          if(presenter.controller.cart.isEmpty){
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('Forma de pagamento',
                      style: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.bold
                      ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Obs: Todos os pagamentos são realizados na entrega do produto",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: size.width * .04
                      ),
                      ),
                    ),
                    ExpansionTile(title: Text('Cartão de crédito',
                    style: TextStyle(
                      fontSize: size.width * .04
                    ),
                    ),
                    children: [
                      if(presenter.controller.cart.order.partner.credit.isEmpty)...[
                        Text("Este estabelecimento não aceita cartão de crédito",
                        style: TextStyle(
                          fontSize: size.width * .05,
                        ),
                        )
                      ]else ...[
                        ...presenter.controller.cart.order.partner.credit.map((e) => 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              state.didChange(FormPayment(
                                name: 'cartão de crédito',
                                type: 'credit',
                                title: e,
                                notThing: true
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                                Icon(IconsPlatform.credit,
                                size: state.value?.title == e ? size.width * .05 : size.width * .04,
                                  color: state.value?.title == e ? Colors.deepOrange : Colors.grey
                                ),
                                Text(e,
                                style: TextStyle(
                                  fontSize: state.value?.title == e ? size.width * .05 : size.width * .04,
                                  color: state.value?.title == e ? Colors.deepOrange : Colors.grey
                                ),
                                )
                              ]
                            ),
                          ),
                        )
                        ).toList()
                      ]
                    ],
                    ),
                    ExpansionTile(title: Text('Cartão de Débito',
                    style: TextStyle(
                      fontSize: size.width * .04
                    ),
                    ),
                    children: [
                      if(presenter.controller.cart.order.partner.debit.isEmpty)...[
                        Text("Este estabelecimento não aceita cartão de Débito",
                        style: TextStyle(
                          fontSize: size.width * .05,
                        ),
                        )
                      ]else ...[
                        ...presenter.controller.cart.order.partner.debit.map((e) => 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              state.didChange(FormPayment(
                                name: 'cartão de débito',
                                type: 'debit',
                                title: e,
                                notThing: true
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                                Icon(IconsPlatform.credit,
                                size: state.value?.title == e ? size.width * .05 : size.width * .04,
                                  color: state.value?.title == e ? Colors.deepOrange : Colors.grey
                                ),
                                Text(e,
                                style: TextStyle(
                                  fontSize: state.value?.title == e ? size.width * .05 : size.width * .04,
                                  color: state.value?.title == e ? Colors.deepOrange : Colors.grey
                                ),
                                )
                              ]
                            ),
                          ),
                        )
                        ).toList()
                      ]
                    ],
                    ),

                    TextButton.icon(onPressed: (){
                      state.didChange(FormPayment(
                        name: 'dinheiro',
                        title: 'money',
                        type: 'real',
                        notThing: false
                        ));
                    }, icon: Icon(IconsPlatform.money,
                    size: state.value?.title == 'money' ?  size.width * .05 : size.width * .04,
                    color: state.value?.title == 'money' ? Colors.deepOrange : Colors.grey
                    ), label: Text('Pagar no dinheiro \$\$',
                    style: TextStyle(
                      fontSize: state.value?.title == 'money' ?  size.width * .05 : size.width * .04,
                      color: state.value?.title == 'money' ? Colors.deepOrange : Colors.grey
                    ),
                    )),
                    state.value?.title == 'money' ? Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.deepOrange,
                          value: state.value?.notThing , 
                        onChanged: (value){
                          state.value.notThing = value;
                          state.didChange(state.value);
                        }),
                        Text('Não precisa de troco',
                        style: TextStyle(
                          fontSize: size.width * .045
                        ),
                        )
                      ],
                    ) : Container(),
                    state.value?.notThing == false ? TextFormField(
                      controller: presenter.controller.fieldController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
                        labelText: 'Troco para quanto?',
                        prefix: Text('R\$',
                        style: TextStyle(
                          fontSize:size.width * .04
                        ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: size.width * .04,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold
                        ),
                        border: OutlineInputBorder()),
                    ):Container()
                  ],
                ),
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal:10),
                height: size.height * .08,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('Total',style: TextStyle(
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold
                        ),),
                        Text(presenter.controller.cart.order.totalPrice.toStringAsFixed(2).replaceAll('.', ','),
                        style: TextStyle(
                          fontSize: size.width * .05,
                          
                        ),
                        )
                      ],
                    ),
                    Expanded(child: Container(
                      height: size.height * .065,
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child: ElevatedButton(
                        child: Text(state.value == null ?'Escolher forma de pagamento' : "Pagar no ${state.value.name}",
                        style: TextStyle(
                          fontSize: size.width * .04,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange
                        ),
                        onPressed: (){
                          presenter.validation();
                        },
                        ),
                    ))
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }

  @override
  notification(text) {
    notificationPopup('Atenção', text);
  }

  @override
  confirmation() {
    showModalWidget(Confirmation(presenter:presenter));
  }

  @override
  success(Order order) {
    AppModule.to<HomeNavigator>().restorePageHomeWithIndexBottomNavigator('/', 1);
    Modular.to.pushNamed('/order',arguments: {'orderId':order.id,
    'partnerId':order.partner.id
    });

  }
}
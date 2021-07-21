import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';

import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';

class DeliveryCart extends StatelessWidget {
  final CartModel cartModel;
  final Size size;
  final Function refresh;
  DeliveryCart({Key key, this.cartModel, this.size, this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FormField<bool>(
          initialValue: cartModel.order.delivery ?? true,
          builder: (state) {
            cartModel.order.delivery = state.value;
            if (refresh != null) {
              refresh();
            }
            return Column(
              children: [
                Row(children: [
                  _tabDelivery('Entrega', state, true),
                  _tabDelivery('Retirar no Local', state, false)
                ]),
                SizedBox(height: 10),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      _img(state.value),
                      state.value ? _tileAddressUser() : _tileAddressPartner()
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          }),
    );
  }

  _tabDelivery(String title, FormFieldState<bool> state, bool status) {
    final activate = state.value == status;
    return InkWell(
      onTap: () {
        state.didChange(status);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: activate ? Colors.brown : Colors.transparent))),
        child: Text(
          title,
          style: TextStyle(
              fontSize: activate ? size.width * .04 : size.width * .037,
              fontWeight: activate ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  _img(bool status) {
    return Container(
      padding: EdgeInsets.all(5),
      height: size.width * .25,
      width: size.width * .25,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black12.withOpacity(.06),
            offset: Offset.zero,
            spreadRadius: 0,
            blurRadius: 9)
      ]),
      child: Stack(
        children: [
          Container(
            height: size.width * .25,
            width: size.width * .25,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/map.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Icon(
              status ? IconsPlatform.editLocation : IconsPlatform.person,
              size: size.width * .07,
            ),
          )
        ],
      ),
    );
  }

  _tileAddressUser() {
    UserModel userModel = AppModule.to<AuthUser>().userModel;
    final style = TextStyle(fontSize: size.width * .032);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Entregar em:',
            style: style,
          ),
          Text(
            "${userModel.address['street']},${userModel.address['numberHome']} - ${userModel.address['complement']}",
            style: style.copyWith(
                fontSize: size.width * .035, fontWeight: FontWeight.bold),
          ),
          Text(
            "${userModel.address['city']} - ${userModel.address['uf']}",
            style: style,
          )
        ],
      ),
    );
  }

  _tileAddressPartner() {
    Partner partner = cartModel.order.partner;
    final style = TextStyle(fontSize: size.width * .032);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Retirar em:',
            style: style,
          ),
          Text(
            "${partner.street},${partner.numberHome} - ${partner.complement}",
            style: style.copyWith(
                fontSize: size.width * .035, fontWeight: FontWeight.bold),
          ),
          Text(
            "${partner.city} - ${partner.uf}",
            style: style,
          )
        ],
      ),
    );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/partner/widgets/app_bar.dart';
import 'package:multidelivery/app/views/partner/widgets/products.dart';
import 'package:multidelivery/app/views/partner/widgets/tab_bar.dart';


import 'package:multidelivery/blocs/products.dart';
import 'package:multidelivery/controllers/partner.dart';
import 'package:multidelivery/presenters/partner.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';

import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/externals/core.dart';

import 'package:multidelivery/src/infra/models/partner.dart' as pt;
import 'package:scroll_to_index/scroll_to_index.dart';


class Partner extends StatefulWidget {
  final pt.Partner partner;
  const Partner({Key key, this.partner}) : super(key: key);

  @override
  _PartnerState createState() => _PartnerState();
}

class _PartnerState extends State<Partner> implements PartnerContract{
  AutoScrollController bodycontroller;
  Size size;
  BlocProducts _blocProducts;
  PartnerPresenter presenter;
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Partner iniciado');
    _blocProducts = BlocProducts(
      AppModule.to<AuthUser>(),
      widget.partner,
      AppModule.to<CoreImpl>().usecaseProduct()
    );
    presenter = PartnerPresenter(
      this,
      PartnerController(widget.partner)
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    
    presenter.controller.maxHeightTab = size.width * .13;

    bodycontroller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
        presenter.controller.scrollController = bodycontroller;
    bodycontroller.addListener(presenter.listnerScrollBody);

  }

  @override
  void dispose() {
    bodycontroller.removeListener(presenter.listnerScrollBody);
    AppModule.to<Config>().showLog('Partner destruido');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarPartner(
            presenter: presenter,
            size: size,
          ),
           TabPartner(
              tabHeight: presenter.controller.tabHeight,
              presenter: presenter,
              controller: bodycontroller,
            ),
          Expanded(
            child: Products(
              bloc: _blocProducts,
              presenter: presenter,
              keyHeader: presenter.controller.keyHeader,
              size: size,
              controller: bodycontroller,),
          ),
        ],
      ),
    );
  }

  @override
  refresh(){
    setState(() {
      
    });
  }
}

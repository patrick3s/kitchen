import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/product/widgets/button_cart.dart';
import 'package:multidelivery/app/views/product/widgets/comment.dart';
import 'package:multidelivery/app/views/product/widgets/complements.dart';
import 'package:multidelivery/app/views/product/widgets/header.dart';
import 'package:multidelivery/controllers/product.dart';
import 'package:multidelivery/presenters/product.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:multidelivery/utils/common_widgets.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({ Key key,this.product }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>  implements ProductContract{
  Size size;
  ProductPresenter presenter;
  Product product;
  @override 
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('ProductDetail Iniciado');
    product = Product.fromMap(widget.product.toMap());
    presenter = ProductPresenter(
      this,ProductController(product,AppModule.to<CartModel>())
    );
    presenter.controller.separateAdditionalByCategory();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    presenter.controller.scrollController =AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);

  }
  @override
  void dispose() {
    AppModule.to<Config>().showLog('ProductDetail destruido');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.product.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * .045,
        ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: presenter.controller.scrollController,
              child: Column(children: [
                HeaderProduct(
                  size: size,
                  product: product,
                ),
                ComplementsDetail(
                  size: size,
                  presenter: presenter,
                ),
                CommentProduct(
                  size:size,
                  presenter:presenter
                )
              ],),
            ),
          ),
          ButtonCart(
            size: size,
            product: product,
            presenter: presenter,
          )
        ],
      ),
    );
  }

  @override
  error(Product product) async {
    final clean = await notificationPopup("Atenção",
     "Seu carrinho contém produtos de outros parceiros, deseja limpar para adicionar o produto desse parceiro?",
     onTap: (){
       presenter.controller.cart.clearCart();
       presenter.addProduct(product);
       Navigator.of(context).pop(true);
     },
     labelButton: "Limpar"
     );
     if(clean ==true){
       Modular.to.pushNamed('cart');
     }
  }

  @override
  refresh() {
    
  }
}
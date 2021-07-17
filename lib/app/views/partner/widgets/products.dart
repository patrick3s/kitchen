import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/views/partner/widgets/header.dart';
import 'package:multidelivery/blocs/products.dart';
import 'package:multidelivery/presenters/partner.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:multidelivery/src/infra/models/product.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:transparent_image/transparent_image.dart';


class Products extends StatelessWidget {
  final BlocProducts bloc;
  final Size size;
  final PartnerPresenter presenter;
  final GlobalKey keyHeader;
  final AutoScrollController controller;
  const Products({ Key key,this.bloc,this.size,this.keyHeader,this.presenter,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductState>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        
        Widget child;
        presenter.controller.separateProducts();
        if(snapshot.data is SuccessProduct){
          
          if(presenter.controller.titlesAndProducts.isEmpty){
          
          child = Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top:60),
            child: Text('Não há produtos por aqui ainda...',
            style: TextStyle(
              fontSize: size.width * .05
            ),
            ),
          );
        }
          }
        if(snapshot.data is LoadingProduct){
          child = Center(
            child: SpinKitThreeBounce(color: Colors.deepOrange,
            size: 20,
            ),
          );
        }

        if(snapshot.data is ErrorProduct){
          
          child = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Desculpe houve um erro',
              style: TextStyle(
                fontSize: size.width * .05
              ),
              ),
              TextButton.icon(onPressed: bloc.load,
               icon: Icon(IconsPlatform.reset),
                label: Text('Tentar novamente'))
            ],
          );
        }
        
        
        
        return SingleChildScrollView(
          controller: controller,
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
            HeaderPartner(
               presenter: presenter,
               size: size,
               key: keyHeader,
             ),
             Container(height: 4.5,
             width: double.infinity,
             color: Colors.grey.withOpacity(.35),
             ),
             if(child != null && presenter.controller.titlesAndProducts.isEmpty)...[
               child
             ] else ...[
               ...List.generate(presenter.controller.titlesAndProducts.length,
               (index) => _separateWidget(presenter.controller.titlesAndProducts[index], index)).toList()
             ]
              
            ],
          ),
        );
      }
    );
  }
  _separateWidget(dynamic data ,int index){
    if(data is Category){
      return _category(data, index);
    }else{
      return _product(data, index);
    }
  }

  _category(Category category, int index){
    return AutoScrollTag(
      index: index,
      key: Key(index.toString()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Text(category.title,
        style: TextStyle(
          fontSize: size.width * .055,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      controller: controller,);
  }
  _product(Product product, int index){
    return InkWell(
      onTap: (){
        Modular.to.pushNamed('/product',arguments: product);
      },
      child: AutoScrollTag(
        index: index,
        key: Key(index.toString()),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1
                ))
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Expanded(child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(product.name,
                              style: TextStyle(
                                fontSize: size.width * .04,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87.withOpacity(.75)
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top:4.0,bottom: 8,right: 4),
                                child: Text(product.description,
                                style: TextStyle(
                                  fontSize: size.width * .035,
                                  color: Colors.blueGrey
                                ),
                                ),
                              ),
                            ]
                          ),
                        )),
                        Text('R\$${product.price.toStringAsFixed(2).replaceAll('.',',')}',
                        style: TextStyle(
                          fontSize:size.width * .04,
                          color:Colors.deepOrange
                        ),
                        )
                      ]
                    ),
                  ),
                  product.img.isEmpty ? Container(): Container(
                    height: size.width * .2,
                    width: size.width * .23,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: product.img,
                      fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        controller: controller,),
    );
  }
}
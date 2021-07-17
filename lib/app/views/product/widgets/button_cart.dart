import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/product.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class ButtonCart extends StatelessWidget {
  final Size size;
  final ProductPresenter presenter;
  final Product product;
  ButtonCart({ Key key ,this.size,this.presenter,this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<Product>(
      initialValue: presenter.controller.product,
      key: presenter.controller.formProduct,
      builder: (state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal:15),
          height: size.height * .1,
          width: size.width,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color:Colors.deepOrange)
                ),
                child:Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        state.value.quantity+=1;
                        state.didChange(state.value);
                      }, icon: Icon(IconsPlatform.add)),
                    Text(state.value.quantity.toString(),
                    style: TextStyle(
                      fontSize: size.width * .05
                    ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        if(state.value.quantity >=2){
                          state.value.quantity-=1;
                          state.didChange(state.value);
                        }
                      }, icon: Icon(IconsPlatform.remove)),
                  ],
                ) ,
              )
              ,
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange
                    ),
                    onPressed: (){
                      presenter.addProduct(product);
                    }, child: Text('Adicionar R\$${state.value.totalPrice().toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * .043
                    ),
                    )),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
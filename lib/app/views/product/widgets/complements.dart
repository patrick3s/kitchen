
import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/product.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/infra/models/additional.dart';
import 'package:multidelivery/src/infra/models/complement.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ComplementsDetail extends StatelessWidget {
  final ProductPresenter presenter;
  final Size size;
  const ComplementsDetail({ Key key,this.presenter ,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Column(
        children: [
          ...List.generate(presenter.controller.product.complements.length, (index) => index).map((int index) {
          final complement = presenter.controller.product.complements[index];
          return AutoScrollTag(
            controller: presenter.controller.scrollController,
            key: Key(index.toString()),
            index: index,
            child: FormField<Complement>(
              initialValue: complement,
              builder: (state) {
               Future.delayed(Duration.zero).then((value) => 
                presenter.controller?.formProduct?.currentState?.didChange(presenter.controller.product)
               );
                complement.quantity = complement.selected.map((e) => e.quantity).toList().fold(0,(previous, current) => previous+current) ?? 0;
                return Column(
                  children: [
                    Container(
                      height: size.width * .15,
                      width: double.infinity,
                      padding: EdgeInsets.all(6),
                      color: Colors.grey.withOpacity(.5),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(complement.title.toUpperCase(),style: TextStyle(
                                fontSize: size.width * .05,
                                fontWeight: FontWeight.bold
                              ),),
                              Text('${complement.quantity} de ${complement.limit}',
                              style: TextStyle(
                                fontSize: size.width * .045
                              ),
                              )
                            ],
                          ),
                          Positioned(
                            right: 10,
                            bottom: size.width * .01,
                            child: complement.mandatory ? Container(
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Text('OBRIGATORIO',
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize:size.width * .035,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                              ),
                            ):Container())
                        ],
                      ),
                    ),
                    ...complement.additionals.map((Additional additional) => _tileComplement(additional, state) ).toList()
                  ],
                );
              }
            ),
          );}).toList()
        ],
      ),
    );
  }

  _tileComplement(Additional additional, FormFieldState<Complement> state){
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.brown.withOpacity(.5)
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(additional.title,
              style: TextStyle(
                fontSize: size.width * .046,
              ),
              ),
              additional.free ? Container():
              Text('+ R\$ ${additional.price.toStringAsFixed(2).replaceAll('.',',')}',
              style: TextStyle(
                fontSize: size.width * .045,
                color: Colors.brown,
                fontWeight: FontWeight.bold
              ),
              )
            ],
          ),
          additional.quantity == 0  ? IconButton(onPressed: (){
            if(state.value.quantity < state.value.limit){
              additional.quantity +=1;
            state.value.selected.add(additional);
            state.didChange(state.value);
            }
            
          }, 
          icon: Icon(IconsPlatform.add,
          size: size.width * .047,
          )) : Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown)
            ),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                  if(state.value.quantity < state.value.limit){
                    
                    additional.quantity+=1;
                  }
                  state.didChange(state.value);
                },
                 icon: Icon(IconsPlatform.add)),
                Text(additional.quantity.toString(),
                style: TextStyle(
                  fontSize: size.width * .05,
                ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                  if(additional.quantity > 0){
                    additional.quantity -=1;
                  }
                  if(additional.quantity == 0){
                    state.value.selected.remove(additional);
                    state.didChange(state.value);
                    return;
                  }
                  state.didChange(state.value);
                },
                 icon: Icon(IconsPlatform.remove))
              ],
            ),
          )
        ],
      ),
    );
  }
}
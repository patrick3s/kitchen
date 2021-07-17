
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/blocs/category.dart';
import 'package:multidelivery/presenters/page_main.dart';
import 'package:multidelivery/shared/pallete_colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:transparent_image/transparent_image.dart';



class TabsMain extends StatelessWidget {
  final Size size;
  final TextStyle styleText;
  final BlocCategory bloc;
  final AutoScrollController controller;
  final MainPresenter presenter;
  const TabsMain({ Key key ,this.presenter, this.controller,this.styleText,this.size, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: StreamBuilder<CategoryState>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if(snapshot.data is LoadingCategory){
            return Container(
              height: size.height * .13,
              width: double.infinity,
              child: SpinKitThreeBounce(
                        color: primaryColor,
                        size: 30,
                      ),
            );
          }

          if(snapshot.data is ErrorCategory){
            return Container(
              height: size.height * .13,
              width: double.infinity,
              child: Text('Desculpe houve um erro, tente novamente',
              style: styleText.copyWith(
                fontSize: size.width * .04
              ),
              ),
            );
          }

          if(snapshot.data is SuccessCategory){
            presenter.controller.setCategory((snapshot.data as SuccessCategory).list);
            return Container(
              height: size.height * .13,
              width: double.infinity,
              child: FormField<int>(
                initialValue: presenter.controller.categoryIndex,
                builder: (state) {
                 
                  presenter.controller.categoryIndex = state.value;
                  Future.delayed(Duration.zero).then((value) => presenter?.controller?.formPartners?.currentState?.didChange(state.value));
                  return ListView(
                    physics: presenter.controller.categoryIndex != -1 ? NeverScrollableScrollPhysics() : null,
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    children: [
                      ...List.generate(presenter.controller.categories.length,
                       (index){
                         
                         final activate = presenter.controller.categoryIndex == index ;
                         return AutoScrollTag(
                           key: ValueKey(index),
                           index: index,
                           controller: controller,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal :4.0),
                                 child: AnimatedOpacity(
                                  
                                   duration: Duration(seconds:1),
                                   opacity: state.value == -1 ? 1.0 : activate ? 1.0 : 0.0,
                                   child: AnimatedContainer(
                                     decoration: BoxDecoration(
                                       color: activate ? Colors.deepOrange : Colors.transparent,
                                       border: Border.all(color:activate? Colors.deepOrange : Colors.black),
                                       borderRadius: BorderRadius.all(Radius.circular(20))
                                     ),
                                     duration: Duration(seconds: 1),
                                     curve: Curves.easeInBack,
                                     height: activate ? size.height * .12 : size.height * .11,
                          width: activate ? size.width * .31 : size.width * .29,
                          child: InkWell(
                                    onTap:activate ? ()async{
                                      if(state.value == index){
                                        state.didChange(-1);
                                        return;
                                      }
                                      state.didChange(index);
                                      await controller.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
                                      
                                    } : state.value == -1 ?()async{
                                      state.didChange(index);
                                      await controller.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
 
                                    } : null,
                                    child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                
                                children: [
                                  Expanded(
                                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
                                     image: presenter.controller.categories[index].img,
                                     fit: BoxFit.cover,
                                     ),
                                  ),
                                  Text(presenter.controller.categories[index].title,
                                  style: styleText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * .035,
                                    color: activate ? Colors.white : Colors.black
                                  ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                                    ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                           );
                       }).toList()
                    ],
                  );
                }
              ),
            );
          }

          return Container();

  
        }
      ),
    );
  }
}
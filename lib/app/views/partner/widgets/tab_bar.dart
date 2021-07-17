import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/partner.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class TabPartner extends StatelessWidget {
  final double tabHeight;
  final PartnerPresenter presenter;
  final AutoScrollController controller;
 
   TabPartner({ Key key,this.tabHeight,this.presenter ,this.controller}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
          height: tabHeight,
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return FormField(
                initialValue: 0,
                key: presenter.controller.form,
                builder: (state) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                       ...List.generate(presenter.controller.partner.categories.length, 
                      (index) => _tab(presenter.controller.partner.categories[index], index , constraints, state.value)).toList()
                    ],
                  );
                }
              );
            }
          ),
        );
  }

  _tab(Category category, int index ,BoxConstraints constraints , int current){    

    final toIndex = presenter.controller.categoryScrollByindex[category.title]  ;
   

    final isActivate = toIndex == current;
    return AutoScrollTag(
      index: index,
      key: Key(index.toString()),
      child: InkWell(
        onTap: (){
        
        
          controller.scrollToIndex(toIndex,
          preferPosition: AutoScrollPosition.begin,
          duration: Duration(seconds: 2)
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: tabHeight == presenter.controller.maxHeightTab
                 ? isActivate  ? Colors.deepOrange : Colors.grey : Colors.transparent,
              ))
            ),
            child: Text(category.title,
            style: TextStyle(
              fontWeight: isActivate  ? FontWeight.bold : FontWeight.normal,
              color: isActivate  ? Colors.deepOrange : Colors.blueGrey,
              fontSize: isActivate  ? constraints.maxHeight * .37 : constraints.maxHeight * .35 
            ),
            ),
          ),
        )),
      controller: controller,
    );
  }

}
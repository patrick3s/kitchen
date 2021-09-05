
import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/custom_product.dart';
import 'package:multidelivery/src/infra/models/additional.dart';
import 'package:multidelivery/utils/common_widgets.dart';
import 'package:multidelivery/utils/models.dart';
import 'package:transparent_image/transparent_image.dart';

class PizzaDetails extends StatefulWidget {
  final Size size;
  final PresenterCustomProduct presenter;
  const PizzaDetails({ Key key,this.size ,this.presenter}) : super(key: key);

  @override
  _PizzaDetailsState createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> with SingleTickerProviderStateMixin {
  List<Additional> _listIngredients =[];
  BoxConstraints _pizzaConstrains;
  bool _initialFocus = false;
  @override
  initState(){
    super.initState();
    widget.presenter.controller.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900)
    );
  }

  @override
  dispose(){
    widget.presenter.controller.animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<bool>(
                  initialValue: _initialFocus,
                  builder: (state) {
                    return DragTarget<Additional>(
                      onAccept: (accept){
                         state.didChange(false);
                        widget.presenter.controller.buildIngredientsAnimation();
                        widget.presenter.controller.animationController.forward(from:0.0);
                      },
                      onWillAccept: (Additional additional){
                        state.didChange(true);
                        for(final ingredient in _listIngredients){
                          if(ingredient.compare(additional)){
                            notificationPopup('Desculpe', 'Você já adicionou esse ingrediente...');
                            return false;
                          }
                        }
                        _listIngredients.add(additional);
                        return true;
                      },
                      onLeave: (leave){
                         state.didChange(false);
                        print('leave');
                      },
                      builder: (context,list,rejects){
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            _pizzaConstrains = constraints;

                            return Center(
                              child: AnimatedContainer(
                                duration: Duration(microseconds: 700),
                                height: state.value ? constraints.maxHeight : constraints.maxHeight - 10,
                                child: Stack(
                      children: [
                                Image.asset('assets/dish.png'),
                                Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Image.asset('assets/pizza-8.png'),
                                )
                      ],
                    ),
                              ),
                            );
                          }
                        );
                      },

                    );
                  }
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Text('Tamanho',
            style: TextStyle(
              fontSize: widget.size.width * .045
            ),
            ),
            Container(
              width: widget.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(widget.presenter.controller.product.sizes.length, (index) => index).map((value) {
                  final e = widget.presenter.controller.product.sizes[value];
                  final activate = widget.presenter.controller.size == value ;
                  return Container(
                    height: 50,
                    width: 50,
                    child: InkWell(
                      onTap: (){
                       
                        widget.presenter.setSize(value);
                      },
                      child: Card(
                        color: activate ? Colors.deepOrange.withOpacity(.65) : Colors.white,
                        elevation: activate ? 10:3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(360))
                        ),
                        child: Center(
                          child: Text(e['title'],
                          style: TextStyle(
                            fontSize: activate ? 25 : 20,
                            color: activate ? Colors.white : Colors.black,
                            fontWeight: activate ? FontWeight.bold : FontWeight.normal 
                          ),
                          ),
                        ),
                      ),
                    ),
                  );}
                  ).toList()
              ],),
            )
          ],

        ),
        AnimatedBuilder(animation: widget.presenter.controller.animationController,
         builder: (context,_){
           return _buildIngredientsWidget();
         })
      ],
    );
  }
  Widget _buildIngredientsWidget(){
    List<Widget> elements = [];
    if(widget.presenter.controller.animationsList.isNotEmpty){
      
      for(int i = 0 ;i<_listIngredients.length ; i++ ){
        Additional ingredient = _listIngredients[i];
        ingredient.positions = positions[i];
        for(int j = 0; j < ingredient.positions.length ; j++){
          final position = ingredient.positions[j];
          final animation = widget.presenter.controller.animationsList[j];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0,fromY = 0.0;
          if(j < 1){
            fromX = - _pizzaConstrains.maxWidth * (1 - animation.value);
          }else if( j < 2){
             fromX =  _pizzaConstrains.maxWidth * (1 - animation.value);
          }else if( j < 4){
             fromY = - _pizzaConstrains.maxHeight * (1 - animation.value);
          }else{
            fromY =  _pizzaConstrains.maxHeight * (1 - animation.value);
          }

          elements.add(
            Transform(
              transform: Matrix4.identity()
              ..translate(
                fromX + _pizzaConstrains.maxWidth * positionX,
                fromY + _pizzaConstrains.maxHeight * positionY
                ),
                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
                image: ingredient.img,
                height: 40,
                ),
              )
          );
        }
        
      }
      return Stack(children: elements,);
      
    }
    return Container();
  }
}
import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/evaluation.dart';
import 'package:multidelivery/shared/icons_platform.dart';

class CommentEvaluation extends StatelessWidget {
  final EvaluationPresenter presenter;
  final Size size;
  const CommentEvaluation({ Key key,this.size,this.presenter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(IconsPlatform.chat,
              size: size.width * .045
              ),
              SizedBox(width: 10,),
              Text('Gostou do pedido? diga aqui...',
              style: TextStyle(
                fontSize: size.width * .045
              ),
              ),
            ],
          ),
          SizedBox(height:10),
          TextFormField(
            maxLines: null,
            onChanged: (text){
              presenter.controller.evaluation.comment = text;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
        ],
      ),
    );
  }
}
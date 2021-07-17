import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/blocs/evaluation.dart';
import 'package:multidelivery/presenters/evaluation.dart';

class ButtonEvaluation extends StatelessWidget {
  final EvaluationPresenter presenter;
  final Size size;
  const ButtonEvaluation({ Key key,this.presenter,this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: StreamBuilder<EvaluationState>(
        stream: presenter.controller.bloc.stream,
        builder: (context, snapshot) {
          if(snapshot.data is LoadingEvaluation){
            return Center(
              child: SpinKitThreeBounce(
                color: Colors.deepOrange,
                size: size.width * .045,
              ),
            );
          }
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange
            ),
            child: Text('Avaliar',
            style: TextStyle(
              fontSize: size.width * .045
            ),
            ),
          onPressed: presenter.evaluation,
          );
        }
      ),
    );
  }
}
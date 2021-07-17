

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/evaluation/widgets/button.dart';
import 'package:multidelivery/app/views/evaluation/widgets/comment.dart';
import 'package:multidelivery/app/views/evaluation/widgets/header.dart';
import 'package:multidelivery/app/views/evaluation/widgets/ratting_evaluation.dart';
import 'package:multidelivery/blocs/evaluation.dart';
import 'package:multidelivery/controllers/evaluation.dart';
import 'package:multidelivery/presenters/evaluation.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/externals/core.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class EvaluationView extends StatefulWidget {
  final Order order;
  const EvaluationView({ Key key,this.order }) : super(key: key);

  @override
  _EvaluationViewState createState() => _EvaluationViewState();
}

class _EvaluationViewState extends State<EvaluationView> implements EvaluationContract{
  EvaluationPresenter presenter;
  Size size;
  @override
  void initState() {
    super.initState();
    presenter = EvaluationPresenter(this,EvaluationController(
      widget.order,
      AppModule.to<AuthUser>(),
      BlocEvaluation(AppModule.to<CoreImpl>().usecaseEvaluation())
      ));
    AppModule.to<Config>().showLog('EvaluationView iniciado');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    super.dispose();
    AppModule.to<Config>().showLog('EvaluationView destruido');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('Avalie',
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * .045,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Column(
        children:[
          AppBarEvaluation(
            size:size,
            presenter:presenter
          ),
          RattingEvaluation(
            presenter: presenter,
            size: size,
          ),
          CommentEvaluation(
            presenter:presenter,
            size:size
          ),
          SizedBox(height: 10,),
          ButtonEvaluation(
            size:size,
            presenter:presenter
          )
        ]
      ),
    );
  }

  @override
  notification(String text) {
    notificationPopup('Atenção', text);
  }

  @override
  success() {
    Modular.to.pop();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/views/partner_evaluation/widgets/header.dart';
import 'package:multidelivery/blocs/evaluation.dart';
import 'package:multidelivery/controllers/partner_evaluation.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/src/externals/core.dart';
import 'package:multidelivery/src/infra/models/evaluation.dart';
import 'package:multidelivery/src/infra/models/partner.dart';

class PartnerEvaluation extends StatefulWidget {
  final Partner partner;
  PartnerEvaluation({ Key key,this.partner }) : super(key: key);
  @override
  _PartnerEvaluationState createState() => _PartnerEvaluationState();
}

class _PartnerEvaluationState extends State<PartnerEvaluation> {
  BlocEvaluation _blocEvaluation;
  Size size;
  PartnerEvaluationController controller;
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('PartnerEvaluation iniciado');
    _blocEvaluation = BlocEvaluation(AppModule.to<CoreImpl>().usecaseEvaluation());
    controller = PartnerEvaluationController();
    _blocEvaluation.load(widget.partner.id);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }
  @override
  void dispose() {
    super.dispose();
    AppModule.to<Config>().showLog('PartnerEvaluation destruido');
    _blocEvaluation.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color:Colors.black),
        title: Column(
          children: [
            Text("Avaliações",
            style: TextStyle(
              color: Colors.black,
              fontSize: AppBar().preferredSize.height * .4
            ),
            ),
            Text(widget.partner.name,
            style: TextStyle(
              fontSize: AppBar().preferredSize.height * .3,
              color: Colors.grey
            ),)
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<EvaluationState>(
        stream: _blocEvaluation.stream,
        builder: (context, snapshot) {
          if(snapshot.data is LoadingEvaluation){
            return Center(
              child: SpinKitThreeBounce(
                size: size.width * .05,
                color: Colors.deepOrange,
              ),
            );
          }

          if(snapshot.data is SuccessEvaluation){
            controller.organizerEvaluationsByDate((snapshot.data as SuccessEvaluation).list);
          }

          return ListView(
            children: [
              HeaderEvaluation(
                partner: widget.partner,
                controller: controller,
              ),
              if(controller.evaluations.isEmpty)...[
                  Center(
                    child: Text('Ainda não há nenhuma avaliação',
                    style: TextStyle(
                      fontSize: size.width * .05
                    ),
                    ),
                  )
              ]else...[
                ...controller.evaluations.map((e) => _evaluation(e)).toList()
              ]   
            ],
          );
        }
      ),
    );
  }
  _evaluation(Evaluation evaluation){
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(IconsPlatform.person),
            Expanded(child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(.5),
                    width: 1
                  )
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(evaluation.name,
                  style: TextStyle(
                    fontSize:  size.width * .04
                  ),),
                  Row(
                    children: [
                      Icon(IconsPlatform.star,
                      color: Colors.orange,
                      size: size.width * .04,
                      
                      ),Text(evaluation.averange.toStringAsFixed(2).replaceAll('.', ','),
                      style: TextStyle(
                        fontSize: size.width * .04
                      ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Text(evaluation.createAtFormat,
                    style: TextStyle(
                      fontSize: size.width * .04
                    ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(evaluation.comment,
                    style: TextStyle(
                      fontSize:size.width * .05
                    ),
                    ),
                  ),
                  evaluation.aswer.isEmpty ? Container():Padding(
                    padding: const EdgeInsets.only(top:8.0,left:8),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Resposta'.toUpperCase(),
                          style: TextStyle(
                            fontSize: size.width * .05,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(height:10),
                          Text(evaluation.aswer,
                          style: TextStyle(
                            fontSize:size.width * .05
                          ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],),
            ))
          ],
        ),
      ),
    );
  }
}
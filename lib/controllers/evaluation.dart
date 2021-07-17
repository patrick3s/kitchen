import 'package:multidelivery/blocs/evaluation.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/evaluation.dart';
import 'package:multidelivery/src/infra/models/order.dart';

class EvaluationController {
  final Order order;
  Evaluation evaluation;
  final AuthUser auth;
  final BlocEvaluation bloc;
  EvaluationController(this.order,this.auth,this.bloc){
    evaluation = Evaluation(averange: 5,
    userId: auth.user.uid,
    partnerId: order.partner.id,
    name: auth.userModel.name,
    orderId: order.id
    );
  }

  Future<EvaluationState> saveEvaluation()async{
    evaluation.createAt = DateTime.now();
    return bloc.create(evaluation.toMap());
  }

}
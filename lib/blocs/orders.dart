import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/usecase/orders.dart';
import 'package:multidelivery/src/infra/models/order.dart';
import 'package:rxdart/subjects.dart';

abstract class OrderState{}
class SuccessOrder extends OrderState {
  final List<Order> list;
  SuccessOrder(this.list);
}
class SuccessOrderWrite extends OrderState {
  final Order order;
  SuccessOrderWrite(this.order);
}
class ErrorOrder extends OrderState {
  final Failure error;
  ErrorOrder(this.error);
}
class LoadingOrder extends OrderState {
}
class IdleOrder extends OrderState {
}

class BlocOrder {
  final UsecaseOrders usecase;
  final AuthUser auth;
  final BehaviorSubject<OrderState> _controller = BehaviorSubject.seeded(IdleOrder());
  BlocOrder(this.usecase,this.auth);
  Stream<OrderState> get stream => _controller.stream;
  OrderState get orders => _controller.stream.value;
  Future<OrderState> create(Order order)async{
    OrderState state;
    _controller.add(LoadingOrder());
    final result = await usecase.create(order);
    result.fold((l) {
      state = SuccessOrderWrite(l);
      _controller.add(state);
      return state;
    }, (r) {
      state = ErrorOrder(r);
      _controller.add(state);
      return state;
    });
    return state;
  }
  load()async{
    _controller.add(LoadingOrder());
    final result = await usecase.getAll(auth.user.uid);
    result.fold((l) {
      _controller.add(SuccessOrder(l));
    }, (r) {
      _controller.add(ErrorOrder(r));
    });
  }
  dispose(){
    _controller.close();
  }

}
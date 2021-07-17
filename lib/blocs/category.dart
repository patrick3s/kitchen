
import 'package:multidelivery/src/domain/usecase/category.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:rxdart/subjects.dart';
abstract class CategoryState {}
class LoadingCategory extends CategoryState {}
class SuccessCategory extends CategoryState {
  final List<Category> list;
  SuccessCategory(this.list);
}
class IdleCategory extends CategoryState {}
class ErrorCategory extends CategoryState {
  final Failure error;
  ErrorCategory(this.error);
}

class BlocCategory {
  final BehaviorSubject<CategoryState> _controller = BehaviorSubject.seeded(IdleCategory());
  Stream<CategoryState> get stream => _controller.stream;
  final UsecaseCategory usecaseCategory;
  BlocCategory(this.usecaseCategory){
    load();
  }
  load()async{
    _controller.add(LoadingCategory());
    final result = await usecaseCategory.search();
    return result.fold((l) => _controller.add(SuccessCategory(l)),
     (r) => _controller.add(ErrorCategory(r)));
  }
  dispose(){
    _controller.close();
  }
}
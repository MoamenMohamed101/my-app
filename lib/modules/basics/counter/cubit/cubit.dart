import 'package:bloc/bloc.dart';
import 'package:first_app/modules/basics/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Countercubit extends Cubit<Counterstates> {
  Countercubit() : super(Initstates());
  static Countercubit get(context) => BlocProvider.of(context);
  void minus() {
    counter--;
   emit(Minusstates(minus: counter));
  }
  void plus() {
    counter++;
    emit(Plusstates(plus: counter));
  }

  var counter = 1;
}

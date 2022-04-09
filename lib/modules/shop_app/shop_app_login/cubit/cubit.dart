import 'package:bloc/bloc.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/shop_app_login/cubit/states.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit(ShopLoginStates initialState)
      : super(ShopLoginInitialStates());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void uselogin(String? email, String? password) {
    emit(ShopLoginLoadingStates());
    Diohelper.postdata(url: login, data: {
      'email': email,
      'password': password,
    })!
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      //print(value.data);
      emit(ShopLoginSucsessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErorrStates(erorr: error));
    });
  }
}

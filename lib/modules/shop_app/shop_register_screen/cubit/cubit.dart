import 'package:bloc/bloc.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/shop_register_screen/cubit/states.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit(ShopRegisterStates initialState)
      : super(ShopRegisterInitialStates());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void useRegister({String? name, String? email, String? password , String? phone}) {
    emit(ShopRegisterLoadingStates());
    Diohelper.postdata(url: Register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    })!
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      //print(value.data);
      emit(ShopRegisterSucsessStates(loginModel!));
    }).catchError((error) {
       print(error.toString());
      emit(ShopRegisterErorrStates(erorr: error));
    });
  }
}

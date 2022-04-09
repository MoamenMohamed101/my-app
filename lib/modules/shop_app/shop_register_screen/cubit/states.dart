import 'package:first_app/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSucsessStates extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSucsessStates(this.loginModel);
}

class ShopRegisterErorrStates extends ShopRegisterStates {
  var erorr;
  ShopRegisterErorrStates({this.erorr});
}

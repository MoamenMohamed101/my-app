import 'package:first_app/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSucsessStates extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSucsessStates(this.loginModel);
}

class ShopLoginErorrStates extends ShopLoginStates {
  var erorr;
  ShopLoginErorrStates({this.erorr});
}

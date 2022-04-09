import 'package:first_app/models/shop_app/change_favorites_model.dart';
import 'package:first_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopStatesinitialState extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopSuccessBottomNavStates extends ShopStates {}

class ShopLoadingBottomNavStates extends ShopStates {}

class ShopErrorBottomNavStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

class ShopSuccessChangeFavoritesStates extends ShopStates {
  final ChangeFavoritesModel? model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopChangeFavoritesStates extends ShopStates {}

class ShopErrorChangeFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}

class ShopSuccessGetUserDataStates extends ShopStates {
  final ShopLoginModel? login;

  ShopSuccessGetUserDataStates(this.login);
}

class ShopLoadingGetUserDataStates extends ShopStates {}

class ShopErrorGetUserDataStates extends ShopStates {}

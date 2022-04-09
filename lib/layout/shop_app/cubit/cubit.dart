import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shop_app/catigories_model.dart';
import 'package:first_app/models/shop_app/change_favorites_model.dart';
import 'package:first_app/models/shop_app/favorites_model.dart';
import 'package:first_app/models/shop_app/home_model.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:first_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:first_app/modules/shop_app/products/products_screen.dart';
import 'package:first_app/modules/shop_app/settings/settings_screen.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopStatesinitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(
      ShopChangeBottomNavStates(),
    );
  }

  Map<int, bool> favorites = {};

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingBottomNavStates());
    Diohelper.getdataa(path: home, token: token)!.then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        // print(homeModel!.data!.products[0].image);
        // print(homeModel!.data!.products[0].inFavorites);
        homeModel!.data!.products.forEach(
          (element) {
            favorites.addAll(
              {
                element.id!: element.inFavorites!,
              },
            );
          },
        );
        //print(favorites.toString());
        emit(
          ShopSuccessBottomNavStates(),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorBottomNavStates());
      },
    );
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    Diohelper.getdataa(path: categories, token: token)!.then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(
          ShopSuccessCategoriesStates(),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorCategoriesStates());
      },
    );
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int idProducts) {
    favorites[idProducts] = !favorites[idProducts]!;
    emit(ShopChangeFavoritesStates());
    Diohelper.postdata(
            url: Favorites, data: {'product_id': idProducts}, token: token)!
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
       print(value.data);
      // print(changeFavoritesModel!.message);
      if (changeFavoritesModel!.status == false) {
        favorites[idProducts] = !favorites[idProducts]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel));
    }).catchError((error) {
      print(error);
      emit(ShopErrorChangeFavoritesStates());
    });
  }
  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesStates());
    Diohelper.getdataa(path: Favorites, token: token)!.then(
          (value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        //printFullText(value.data.toString());
        emit(
          ShopSuccessGetFavoritesStates(),
        );
      },
    ).catchError(
          (error) {
        print(error.toString());
        ShopErrorGetFavoritesStates();
      },
    );
  }
  ShopLoginModel? shopLoginModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataStates());
    Diohelper.getdataa(path: Profile, token: token)!.then(
          (value) {
        shopLoginModel = ShopLoginModel.fromJson(value.data);
        //printFullText(value.data.toString());
        print(shopLoginModel!.data!.token);
        emit(
          ShopSuccessGetUserDataStates(shopLoginModel),
        );
      },
    ).catchError(
          (error) {
        print(error.toString());
        ShopErrorGetUserDataStates();
      },
    );
  }

}

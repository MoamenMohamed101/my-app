import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/shop_app_login/cubit/states.dart';
import 'package:first_app/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit(SocialLoginStates initialState)
      : super(SocialLoginInitialStates());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void uselogin({String? email, String? password}) {
    emit(SocialLoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
      emit(SocialLoginSucsessStates(uid: value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErorrStates(erorr: error.toString()));
    });
  }
}

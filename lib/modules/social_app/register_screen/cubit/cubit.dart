import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/social_app/social_user_model.dart';
import 'package:first_app/modules/social_app/register_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit(SocialRegisterStates initialState)
      : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  useRegister({String? name, String? email, String? password, String? phone}) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      createUser(
          name: name,
          phone: phone,
          email: email,
          uId: value.user!.uid,
          password: password);
      //emit(SocialRegisterSucsessStates());
    }).catchError((error) {
      print(error);
      emit(SocialRegisterErorrStates());
    });
  }

  createUser(
      {String? name,
      String? email,
      String? phone,
      String? uId,
      dynamic password}) {
    SocialUserModel? socialUserModel = SocialUserModel(
        email: email,
        phone: phone,
        name: name,
        uId: uId,
        password: password,
        isEmailVerified: false,
        image:
            'https://www.doylemahon.ie/wp-content/uploads/2019/11/Man-Gentleman-Avatar-Silhouette-Free-Vector-Graphi-3774.jpg',
        bio: 'write your bio...',
        cover:
            'https://www.doylemahon.ie/wp-content/uploads/2019/11/Man-Gentleman-Avatar-Silhouette-Free-Vector-Graphi-3774.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(socialUserModel.toMap())
        .then((value) {
      emit(SocialCreateUserSucsessStates());
    }).catchError((error) {
      print(error);
      emit(SocialCreateUserErorrStates());
    });
  }
}
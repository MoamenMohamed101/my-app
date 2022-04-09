import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/social_user_model.dart';
import 'package:first_app/modules/social_app/chats/chats_screen.dart';
import 'package:first_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:first_app/modules/social_app/settings/settings_screen.dart';
import 'package:first_app/modules/social_app/users/users_screen.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(initialState) : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? socialUserModel;

  void getUserData() {
    emit(SocialLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId!)
        .get()
        .then((value) {
      socialUserModel = SocialUserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'News Feeds',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if(index == 2)
      emit(SocialNewPostStates());
    else
    currentIndex = index;
    emit(SocialChangeBottomNavStates());
  }
}
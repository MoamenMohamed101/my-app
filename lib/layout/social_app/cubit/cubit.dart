import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/social_user_model.dart';
import 'package:first_app/modules/social_app/chats/chats_screen.dart';
import 'package:first_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:first_app/modules/social_app/new_post/new_post.dart';
import 'package:first_app/modules/social_app/settings/settings_screen.dart';
import 'package:first_app/modules/social_app/users/users_screen.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(initialState) : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId!)
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(
        SocialErrorStates(
          error.toString(),
        ),
      );
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPost(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'News Feeds',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialNewPostStates());
    else
      currentIndex = index;
    emit(SocialChangeBottomNavStates());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(
        SocialProfileImagePickedSuccessStates(),
      );
    } else {
      print('No image selected');
      emit(
        SocialProfileImagePickedErrorStates(),
      );
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(
        SocialCoverImagePickedSuccessStates(),
      );
    } else {
      print('No image selected');
      emit(
        SocialCoverImagePickedErrorStates(),
      );
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage!.path).pathSegments.last}',
        )
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        emit(SocialUploadProfileImageSuccessStates());
      }).catchError(() {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(coverImage!.path).pathSegments.last}',
        )
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        emit(SocialUploadCoverImageSuccessStates());
      }).catchError(() {
        emit(SocialUploadCoverImageErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadCoverImageErrorStates());
    });
  }

  void updateUserImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null && profileImage != null) {
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }

  updateUser({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null && profileImage != null) {
    } else {
      SocialUserModel? model = SocialUserModel(
        phone: phone,
        name: name,
        isEmailVerified: false,
        bio: bio,
        email: userModel!.email,
        password: userModel!.password,
        uId: userModel!.uId,
        cover: userModel!.cover,
        image: userModel!.image,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId!)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error) {
        print(error);
        emit(SocialUserUpdateErrorStates());
      });
    }
  }
}
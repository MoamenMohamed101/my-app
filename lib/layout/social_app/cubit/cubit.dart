import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/post_model.dart';
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

import '../../../models/social_app/chats_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(initialState) : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  //To get the user data from the firebase
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
    NewPost(),
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
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostStates());
    else
      currentIndex = index;
    emit(SocialChangeBottomNavStates());
  }

  //To get the image from the gallery
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

  // To get the cover image from the gallery
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

  //To upload the profile image to the firebase storage
  void uploadProfileImage({
    String? name,
    String? phone,
    String? bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage!.path).pathSegments.last}',
        )
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
        //emit(SocialUploadProfileImageSuccessStates());
      }).catchError(() {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  //To upload the cover image to the firebase storage
  void uploadCoverImage({
    String? name,
    String? phone,
    String? bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(coverImage!.path).pathSegments.last}',
        )
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        //emit(SocialUploadCoverImageSuccessStates());
      }).catchError(() {
        emit(SocialUploadCoverImageErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadCoverImageErrorStates());
    });
  }

  // void updateUserImage({
  //   @required String? name,
  //   @required String? phone,
  //   @required String? bio,
  // }) {
  //   emit(SocialUserUpdateLoadingStates());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  // To update user data
  updateUser({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUserUpdateLoadingStates());
    SocialUserModel? model = SocialUserModel(
      phone: phone,
      name: name,
      isEmailVerified: false,
      bio: bio,
      email: userModel!.email,
      password: userModel!.password,
      uId: userModel!.uId,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
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

  File? postImage;

  // remove post image
  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemovedStates());
  }

  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(
        SocialPostImagePickedSuccessStates(),
      );
    } else {
      print('No image selected');
      emit(
        SocialPostImagePickedErrorStates(),
      );
    }
  }

  //To upload the post image to the firebase storage
  void uploadPostImage({
    @required String? dateTime,
    @required String? text,
  }) {
    emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'posts/${Uri.file(postImage!.path).pathSegments.last}',
        )
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError(() {
        emit(SocialCreatePostErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(SocialCreatePostErrorStates());
    });
  }

  //To create a post
  createPost({
    @required String? text,
    @required String? dateTime,
    @required String? postImage,
  }) {
    emit(SocialCreatePostLoadingStates());
    PostModel? model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialCreatePostErrorStates());
    });
  }

  //To get the posts from the firebase firestore
  List<PostModel> posts = [];
  List<String?> postId = [];
  List<int?> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingStates());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
      });
      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialGetPostsErrorStates());
    });
  }

  //To send likes to the firebase firestore
  void likePosts(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostsSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialLikePostsErrorStates());
    });
  }

  List<SocialUserModel>? users;

  void getUsers() {
    // emit(SocialGetPostsLoadingStates());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId)
          users!.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialGetPostsErrorStates());
    });
  }

  // send message to the firebase firestore
  void sendMessage({
    @required String? text,
    @required String? dateTime,
    @required String? receiverId,
  }) {
    MessageModel? model = MessageModel(
      senderId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialSendMessagesErrorStates());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialSendMessagesErrorStates());
    });
  }

  // get the messages from the firebase firestore
  List<MessageModel> messages = [];

  getMessages(String? receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessStates());
    });
  }
}

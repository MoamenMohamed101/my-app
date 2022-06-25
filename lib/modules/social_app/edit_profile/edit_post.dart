import 'dart:async';
import 'dart:math';

import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPost extends StatelessWidget {
  EditPost({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: defultAppBar(
            context: context,
            text: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  // SocialCubit.get(context).updateUserImage(
                  //     name: nameController.text,
                  //     phone: phoneController.text,
                  //     bio: bioController.text);
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingStates)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingStates)
                    const SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 225,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    topLeft: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, top: 5),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon:
                                        const Icon(IconBroken.Camera, size: 25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 54,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider),
                            ),
                            CircleAvatar(
                              radius: 16,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const Icon(IconBroken.Camera, size: 17.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: double.infinity,
                                  height: 50,
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    },
                                    child: const Text(
                                      'upload profile image',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.5),
                                    ),
                                  ),
                                ),
                                if(state is SocialUserUpdateLoadingStates)
                                 const SizedBox(
                                  height: 5,
                                ),
                                if(state is SocialUserUpdateLoadingStates)
                                 const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: double.infinity,
                                  height: 50,
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    child: const Text(
                                      'upload cover image',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.5),
                                    ),
                                  ),
                                ),
                                if(state is SocialUserUpdateLoadingStates)
                                 const SizedBox(
                                  height: 5,
                                ),
                                if(state is SocialUserUpdateLoadingStates)
                                 const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name is empty';
                      }
                      return null;
                    },
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.User),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bio is empty';
                      }
                      return null;
                    },
                    controller: bioController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Info_Circle),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone is empty';
                      }
                      return null;
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Call),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

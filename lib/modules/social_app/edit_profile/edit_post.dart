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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).socialUserModel;
        var profileImage = SocialCubit.get(context).profileImage;
        return Scaffold(
          appBar: defultAppBar(
            context: context,
            text: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {},
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
            child: Column(
              children: [
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
                                  image: NetworkImage('${userModel!.cover}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              child: CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(IconBroken.Camera, size: 25),
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
                                    : FileImage(profileImage) as ImageProvider),
                          ),
                          CircleAvatar(
                            radius: 15,
                            child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const Icon(IconBroken.Camera, size: 17),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
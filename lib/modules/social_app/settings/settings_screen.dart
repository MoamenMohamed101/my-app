import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/modules/social_app/edit_profile/edit_post.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).socialUserModel;
        return Padding(
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
                      child: Container(
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
                    ),
                    CircleAvatar(
                      radius: 54,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${userModel.image}'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(
                height: 10,
              ),
              Text('${userModel.bio}',
                  style: Theme.of(context).textTheme.caption),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('Posts',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('100',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('265',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('photos',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('followers',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('64',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('followings',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Add Photos'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      NavigateTo(context: context, widget: EditPost());
                    },
                    child: const Icon(IconBroken.Edit, size: 16),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

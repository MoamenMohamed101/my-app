import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/modules/social_app/chats/chats_screen.dart';
import 'package:first_app/modules/social_app/new_post/new_post.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {
        if(state is SocialNewPostStates){
          NavigateTo(
            context: context,
            widget: const NewPost()
          );
        }
      },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Location'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
// Column(
//                 children: [
//                   if (!FirebaseAuth.instance.currentUser!.emailVerified == true)
//                     Container(
//                       color: Colors.amber.withOpacity(.6),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.info_outline),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             const Expanded(
//                               child: Text('please verify your email'),
//                             ),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 FirebaseAuth.instance.currentUser!
//                                     .sendEmailVerification()
//                                     .then((value) {
//                                   showtost(
//                                       masg: 'cheak your email',
//                                       state: ToastStates.SUCCESS);
//                                 }).catchError((error) {
//                                   print(error);
//                                 });
//                               },
//                               child: const Text(
//                                 'send',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               );

import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost extends StatelessWidget {
  NewPost({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: defultAppBar(
            context: context,
            text: 'Create post',
            actions: [
              TextButton(
                onPressed: () {
                  var time = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      text: textController.text,
                      dateTime: time.toString(),
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                        dateTime: time.toString(), text: textController.text);
                  }
                },
                child: const Text(
                  'post',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingStates)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingStates)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/success-celebration-excitement-victory-concept-cheerful-senior-man-with-thick-beard-clenching-fists-screaming-yes_343059-4057.jpg?w=1060'),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text('Moamen Mohamed'),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'what is in your mind?',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20,),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, top: 5),
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: const Icon(Icons.close, size: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add photo',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

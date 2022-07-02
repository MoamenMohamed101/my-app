import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/chats_model.dart';
import 'package:first_app/models/social_app/social_user_model.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  var textController = TextEditingController();

  ChatDetailsScreen({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(userModel!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userModel?.image}'),
                      radius: 25,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${userModel?.name}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit
                    .get(context)
                    .messages
                    .isNotEmpty,
                fallback: (BuildContext context) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(itemBuilder: (context , index){
                            var message = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel!.uId == message.senderId) {
                              return buildMyMessage(message);
                            }
                            return buildMessage(message);
                          },
                              separatorBuilder: (context , index){
                            return const SizedBox(height: 10,);
                              },
                              itemCount: SocialCubit.get(context).messages.length),
                        ),
                        const Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: textController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ....',
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: primryswatsh,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        text: textController.text,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: userModel!.uId);
                                  },
                                  child: const Icon(
                                    IconBroken.Send,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(20),
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
            ),
          ),
          child: Text('${model.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: primryswatsh.withOpacity(.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(20),
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
            ),
          ),
          child: Text('${model.text}'),
        ),
      );
}

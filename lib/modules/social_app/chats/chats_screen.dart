import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/social_user_model.dart';
import '../chat_details/chat_details.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users!.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(SocialCubit.get(context).users![index],context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 1,
                    ),
                  ),
              itemCount: SocialCubit.get(context).users!.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget buildChatItem(SocialUserModel model,context) => InkWell(
        onTap: () {
          NavigateTo(
              context: context, widget: ChatDetailsScreen(userModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Text(
                '${model.name}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );
}

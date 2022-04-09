import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';

class Archivetasksscreen extends StatelessWidget {
  const Archivetasksscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Apployout, Applayoutstates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        Apployout cubit = Apployout.get(context);
        var taskss = Apployout.get(context).archivelists;
        return ConditionalBuilder(
          condition: taskss.length > 0,
          builder: (conntext) => ListView.separated(
              itemBuilder: (context, index) =>
                  BuildTaskItem(cubit.archivelists[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 1,
                    ),
                  ),
              itemCount: cubit.archivelists.length),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.menu,
                  size: 100,
                  color: Colors.grey,
                ),
                Text(
                  'Enter task please',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

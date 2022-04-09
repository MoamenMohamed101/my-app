import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/layout/news_app/Cubit/cubit.dart';
import 'package:first_app/layout/news_app/Cubit/states.dart';
import 'package:first_app/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).Science;
        return articalBuilder(list,context);
      },
      listener: (BuildContext context, state) {},
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/layout/news_app/Cubit/cubit.dart';
import 'package:first_app/layout/news_app/Cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';

import '../../modules/news_app/search/search.dart';

class  NewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentindex],
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  NavigateTo(context: context, widget: SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                icon: const Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  Apployout.get(context).changeApptheme();
                },
              ),
            ],
            title: const Text('NewsApp'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items: cubit.bottomnav,
            onTap: (index) {
              cubit.change(index);
            },
          ),
        );
      },
    );
  }
}

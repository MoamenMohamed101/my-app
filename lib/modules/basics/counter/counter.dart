import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Counterscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Countercubit(),
      child: BlocConsumer<Countercubit , Counterstates>(
        builder: (context , state) => Scaffold(
          appBar: AppBar(
            title: const Text('Counter'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Countercubit.get(context).plus();
                  },
                  child: const Text(
                    'Plus',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '${Countercubit.get(context).counter}',
                    style: const TextStyle(fontSize: 70),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Countercubit.get(context).minus();
                  },
                  child: const Text(
                    'Miuns',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context , state){
          if(state is Plusstates)  print('${state.plus} Plus done');
          if(state is Minusstates) print('${state.minus} Minus done');
        },
      ),
    );
  }
}
//create: (BuildContext,context) => Countercubit(),
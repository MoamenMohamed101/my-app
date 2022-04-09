import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class Homelayout extends StatelessWidget {
  var Scaffoldd = GlobalKey<ScaffoldState>();
  var validate = GlobalKey<FormState>();
  var  titelcontroler = TextEditingController();
  var timecontroler = TextEditingController();
  var datecontroler = TextEditingController();
  // tasks.length > 0
  // ?
  //     : ,
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Apployout()..createDatabase(),
      child: BlocConsumer<Apployout, Applayoutstates>(
        builder: (BuildContext context, Applayoutstates state) {
          Apployout cubit = Apployout.get(context);
          return Scaffold(
            key: Scaffoldd,
            body: ConditionalBuilder(
                condition: state is! AppGetDataBasestates,
                builder: (context) {
                  return cubit.tasks[cubit.intcurrent!];
                },
                fallback: (context) {
                  return const Center(child: CircularProgressIndicator());
                }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              showSelectedLabels: true,
              currentIndex: cubit.intcurrent!,
              onTap: (index) {
                // setState(() {});
                Apployout.get(context).changenavigator(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tacks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archive'),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                //isBottomSheetShown
                if (cubit.isBottomSheetShown!) {
                  if (validate.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titelcontroler.text,
                        date: datecontroler.text,
                        time: timecontroler.text);
                    // insertTodatabase(
                    //         date: datecontroler.text,
                    //         time: timecontroler.text,
                    //         title: titelcontroler.text)
                    //     .then((value) {
                    //   getdatafromdatabase(database).then((value) {
                    //
                    //     // setState(() {
                    //     //   flotingicon = Icons.edit;
                    //     //   change = false;
                    //     //   lists = value;
                    //     //   print(lists);
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  //setState(() {});
                  //cubit.ChangeButtom(isshow: false, icon: Icons.edit);
                  // flotingicon = Icons.add;
                  // change = true;
                  Scaffoldd.currentState!
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: validate,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defultformfield(
                                          ontap: () {},
                                          controller: titelcontroler,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'Write your task';
                                            }
                                          },
                                          keybord: TextInputType.name,
                                          labletext: 'Ente your task',
                                          icon: const Icon(Icons.title),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        defultformfield(
                                          ontap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) {
                                              timecontroler.text = value!
                                                  .format(context)
                                                  .toString();
                                              print(
                                                value.format(context),
                                              );
                                            });
                                          },
                                          controller: timecontroler,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'What\'s the Time?';
                                            }
                                          },
                                          keybord: TextInputType.datetime,
                                          labletext: 'Enter time',
                                          icon: const Icon(Icons.watch_later),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        defultformfield(
                                          ontap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2021-12-01'),
                                            ).then((value) {
                                              datecontroler.text =
                                                  DateFormat.yMMMd()
                                                      .format(value!);
                                            });
                                          },
                                          controller: datecontroler,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'What\'s the date?';
                                            }
                                          },
                                          keybord: TextInputType.datetime,
                                          labletext: 'Enter Date',
                                          icon: const Icon(Icons.calendar_today),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          elevation: 17)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isshow: false,
                      icon: Icons.edit,
                    );
                    //Navigator.pop(context);
                  });

                  cubit.changeBottomSheetState(
                    isshow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.flotingicon),
            ),
            appBar: AppBar(
              title: Text(cubit.names[cubit.intcurrent!]),
            ),
          );
        },
        listener: (context, state) {
          if (state is AppInsertDatabasestates) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Future<String> printname() async {
    return 'moamen';
  }
}

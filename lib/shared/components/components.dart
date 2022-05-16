import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:first_app/shared/cubit/cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/news_app/web_view/web_view.dart';

Widget defultbutton({
  Color? color = Colors.blue,
  double? width = double.infinity,
  double? rudis,
  VoidCallback? function,
  String? text,
  bool isuppercase = true,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rudis!),
        color: color,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isuppercase ? text!.toUpperCase() : text!,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );

Widget defultformfield({
  @required TextEditingController? controller,
  String? Function(String?)? onfield,
  String? Function(String?)? onchange,
  VoidCallback? ontap,
  @required String? Function(String?)? validate,
  VoidCallback? suffixpress,
  @required TextInputType? keybord,
  @required String? labletext,
  @required Widget? icon,
  IconData? suffix,
  bool? ispasswordobscure = false,
  bool? isenable = true,
}) =>
    TextFormField(
      enabled: isenable,
      onTap: ontap!,
      obscureText: ispasswordobscure!,
      validator: validate,
      controller: controller,
      onFieldSubmitted: onfield,
      onChanged: onchange,
      keyboardType: keybord,
      decoration: InputDecoration(
        labelText: labletext,
        border: const OutlineInputBorder(),
        prefixIcon: icon,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixpress,
              )
            : null,
      ),
    );

BuildTaskItem(Map Model, context) => Dismissible(
      onDismissed: (direction) {
        Apployout.get(context).deleteData(id: Model['id']);
      },
      key: Key(Model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              child: Text(
                '${Model['time']}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${Model['title']}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${Model['date']}'),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                Apployout.get(context)
                    .updateData(status: 'done', id: Model['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                Apployout.get(context)
                    .updateData(status: 'archive', id: Model['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );

BiuldArticalItem(articles, context) => InkWell(
      onTap: () {
        NavigateTo(
          context: context,
          widget: WebViewScreen(articles['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${articles['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${articles['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${articles['publishedAt']}',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articalBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (BuildContext context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              BiuldArticalItem(list[index], context),
          separatorBuilder: (BuildContext context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
          itemCount: 20),
      fallback: (context) => Center(
        child: isSearch ? Container() : const CircularProgressIndicator(),
      ),
    );

void NavigateTo({context, widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinsh({context, widget}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

void showtost({@required String? masg, @required ToastStates? state}) =>
    Fluttertoast.showToast(
      msg: masg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastcolor(state!),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, waring }

Color? color;

Color? chooseToastcolor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.waring:
      color = Colors.yellow;
      break;
  }
  return color;
}

defultAppBar({
  @required BuildContext? context,
  String? text,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context!);
        },
        icon: const Icon(IconBroken.Arrow___Left),
      ),
      actions: actions,
      title: Text(text!),
    );

import 'package:first_app/modules/shop_app/shop_app_login/shop_app_login.dart';
import 'package:first_app/shared/network/remote/cash_helper.dart';
import '../../layout/social_app/cubit/cubit.dart';
import 'components.dart';

void signOut(context) {
  CashHelper.removedata(key: 'token').then(
    (value) {
      if (value)
        NavigateAndFinsh(
          context: context,
          widget: ShopLoginScreen(),
        );
    },
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach(
        (element) => print(
          element.group(0),
        ),
      );
}

String? token = '';
String? uId = '';
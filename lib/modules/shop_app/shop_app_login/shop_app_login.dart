import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/shop_app/shop_layout.dart';
import 'package:first_app/modules/shop_app/shop_app_login/cubit/cubit.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/remote/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shop_register_screen/shop_register_screen.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  //signingReport
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ShopLoginCubit(ShopLoginInitialStates()),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucsessStates) {
            if (state.loginModel.status == true) {
              CashHelper.savedata(
                      key: 'token', value: state.loginModel.data!.token)!
                  .then(
                (value) {
                  token = state.loginModel.data!.token;
                  NavigateAndFinsh(
                    context: context,
                    widget: const ShopLayout(),
                  );
                },
              );
              showtost(
                  masg: state.loginModel.message, state: ToastStates.SUCCESS);
              print(state.loginModel.data!.token);
            } else {
              showtost(
                  masg: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login now with our hotel',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email is empty';
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          labelText: 'Email Adress',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is empty';
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          ShopLoginCubit.get(context).uselogin(
                              emailController.text, passwordController.text);
                          if (formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingStates,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              ShopLoginCubit.get(context).uselogin(
                                  emailController.text,
                                  passwordController.text);
                              if (formKey.currentState!.validate()) {
                                print(emailController.text);
                                print(passwordController.text);
                              }
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have acount ?'),
                          TextButton(
                            onPressed: () {
                              NavigateTo(
                                  context: context,
                                  widget: ShopRegisterScreen());
                            },
                            child: Text(
                              'Register now'.toUpperCase(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//moamenmohamed@gmail.com
//123456789
// 6A:53:C4:53:3C:AD:3D:E3:29:22:BB:BC:AE:81:13:75:33:33:86:A8
// gradlew signingReport
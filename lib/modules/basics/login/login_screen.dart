import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/shared/components/components.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailcontrolar = TextEditingController();

  var passwordcontrolar = TextEditingController();

  var Formkey = GlobalKey<FormState>();

  var ispassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: Formkey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defultformfield(
                      labletext: 'Email Adress',
                      controller: emailcontrolar,
                      icon: Icon(Icons.email),
                      keybord: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email adress must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defultformfield(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Password adress must not be empty';
                        }
                        return null;
                      },
                      keybord: TextInputType.visiblePassword,
                      icon: Icon(Icons.lock),
                      controller: passwordcontrolar,
                      labletext: 'Password',
                      ispasswordobscure: ispassword,
                      suffix: ispassword ? Icons.visibility_off : Icons.visibility,
                      suffixpress: () {
                        setState(() {
                          ispassword  = !ispassword;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defultbutton(
                      rudis: 10,
                      color: Colors.blue,
                      text: 'login',
                      function: () {
                        if (Formkey.currentState!.validate()) {
                          print(emailcontrolar.text);
                          print(passwordcontrolar.text);
                        }
                      },
                      width: double.infinity),
                  SizedBox(
                    height: 10,
                  ),
                  defultbutton(
                      rudis: 10,
                      isuppercase: false,
                      color: Colors.blue,
                      text: 'login',
                      function: () {
                        if (Formkey.currentState!.validate()) {
                          print(emailcontrolar.text);
                          print(passwordcontrolar.text);
                        }
                      },
                      width: double.infinity),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have any account?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Regester Now'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:athens/constants/theme_model.dart';
import 'package:athens/model/user.dart';
import 'package:athens/screens/heroes/choose_hero.dart';
import 'package:athens/screens/overview.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/service/skeleton/authentication.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ThemeModel theme = ThemeModel.instance;

  final Authentication _auth = Authentication();

  bool _processing = false;
  String? _fullName;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Welcome to Waste Warriors!',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Full name',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty)
                        return 'Enter a valid username';
                      else
                        return null;
                    },
                    onChanged: (String? value) => _fullName = value,
                    onSaved: (String? value) => _fullName = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Email',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty ||
                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value))
                        return 'Enter a valid email';
                      else
                        return null;
                    },
                    onChanged: (String? value) => _email = value,
                    onSaved: (String? value) => _email = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Password',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty || value.length < 6)
                        return 'Enter a password longer than 6 characters';
                      else
                        return null;
                    },
                    onChanged: (String? value) => _password = value,
                    onSaved: (String? value) => _password = value,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 70,
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.maincolor,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    child: !_processing
                        ? Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          )
                        : const CircularProgressIndicator(
                        backgroundColor: Colors.white),
                    onPressed: () async {
                      bool submitted = await _submitForm();
                      if (submitted) {
                        Routing.moveToPage(context, ChooseHero());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    setState(() => _processing = true);
    try {
      await _auth.signUp(_fullName!, _email!, _password!);
      setState(() => _processing = false);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

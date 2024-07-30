import 'package:aula_firebase/pages/forgotPassPage.dart';
import 'package:aula_firebase/pages/homePage.dart';
import 'package:aula_firebase/pages/listUsersPage.dart';
import 'package:aula_firebase/pages/loginPage.dart';
import 'package:aula_firebase/pages/registerPersonPage.dart';
import 'package:aula_firebase/pages/signUpPage.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const homePage = '/homePage';
  static const registerPersonPage = '/registerPersonPage';
  static const listUsersPage = '/listUsersPage';
  static const loginPage = '/loginPage';
  static const signUpPage = '/signUpPage';
  static const forgotPassPage = '/forgotPassPage';

  // static const signUpPage = '/signUpPage';
  // static const loginPage = '/loginPage';
  // static const forgotPassPage = '/forgotPassPage';

  static Map<String, WidgetBuilder> define() {
    return {
      homePage: (BuildContext context) => HomePage(),
      registerPersonPage: (BuildContext context) => RegisterPersonPage(),
      listUsersPage: (BuildContext context) => ListUsersPage(),
      loginPage: (BuildContext context) => LoginPage(),
      signUpPage: (BuildContext context) => SignUpPage(),
      forgotPassPage: (BuildContext context) => ForgotPassPage(),
      // signUpPage: (BuildContext context) => SignUpPage(),
      // loginPage: (BuildContext context) => LoginPage(),
      // forgotPassPage: (BuildContext context) => ForgotPassPage(),
    };
  }
}

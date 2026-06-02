import 'package:expenso_492/ui/dashboard/dashboard_page.dart';
import 'package:expenso_492/ui/user_on_boarding/login/login_page.dart';
import 'package:expenso_492/ui/user_on_boarding/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../ui/splash/splash_page.dart';

class AppRoutes{

  static const String SPLASH_PAGE = "/";
  static const String LOGIN_PAGE = "/login";
  static const String SIGNUP_PAGE = "/sign_up";
  static const String DASHBOARD_PAGE = "/dashboard";


  static Map<String, WidgetBuilder> mRoutes() => {
    SPLASH_PAGE : (_) => SplashPage(),
    LOGIN_PAGE : (_) => LoginPage(),
    SIGNUP_PAGE : (_) => SignUpPage(),
    DASHBOARD_PAGE : (_) => DashboardPage(),
  };

}
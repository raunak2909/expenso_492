
import 'package:expenso_492/domain/constants/app_routes.dart';
import 'package:expenso_492/ui/splash/splash_page.dart';
import 'package:expenso_492/ui/user_on_boarding/login/login_page.dart';
import 'package:expenso_492/ui/user_on_boarding/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.SPLASH_PAGE,
      routes: AppRoutes.mRoutes(),
    );
  }
}

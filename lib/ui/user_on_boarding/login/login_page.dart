import 'package:expenso_492/domain/ui_helper/input_field_decoration.dart';
import 'package:flutter/material.dart';

import '../../../domain/constants/app_routes.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hi, Welcome back!", style: TextStyle(fontSize: 34)),
              SizedBox(height: 11),
              TextField(
                controller: emailController,
                decoration: mFieldDecor(
                  hint: "Enter your email here",
                  label: "Email",
                ),
              ),
              SizedBox(height: 11),
              TextField(
                obscureText: true,
                controller: passController,
                decoration: mFieldDecor(
                  hint: "Enter your password here",
                  label: "Password",
                ),
              ),
              SizedBox(
                height: 11,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21)
                    )
                  ),
                    onPressed: (){

                }, child: Text('Login')),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                        context,
                        AppRoutes.SIGNUP_PAGE);
                  },
                  child: Text.rich(TextSpan(
                    text: "Don't have an account, ",
                    children: [
                      TextSpan(text: "Create now..", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade200
                      )),
                    ]
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

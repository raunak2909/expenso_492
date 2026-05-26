import 'package:flutter/material.dart';

import '../../../domain/ui_helper/input_field_decoration.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isPassVisible = false;
  bool isConfirmPassVisible = false;

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
              Text("Hi, Create Account!", style: TextStyle(fontSize: 34)),
              SizedBox(height: 11),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: mFieldDecor(
                  hint: "Enter your email here",
                  label: "Email",
                ),
              ),
              SizedBox(height: 11),
              TextField(
                controller: nameController,
                decoration: mFieldDecor(
                  hint: "Enter your name here",
                  label: "Name",
                ),
              ),
              SizedBox(height: 11),
              TextField(
                controller: mobNoController,
                keyboardType: TextInputType.phone,
                decoration: mFieldDecor(
                  hint: "Enter your Mobile no here",
                  label: "Mobile No",
                ),
              ),
              SizedBox(height: 11),
              StatefulBuilder(
                builder: (context, ss) {
                  return TextField(
                    obscureText: !isPassVisible,
                    controller: passController,
                    decoration: mFieldDecor(
                      isPassField: true,
                      isPassVisible: isPassVisible,
                      callBack: (){
                        isPassVisible = !isPassVisible;
                        ss((){});
                      },
                      hint: "Enter your password here",
                      label: "Password",
                    ),
                  );
                }
              ),
              SizedBox(height: 11),
              StatefulBuilder(
                builder: (context, ss) {
                  return TextField(
                    obscureText: !isConfirmPassVisible,
                    controller: confirmPassController,
                    decoration: mFieldDecor(
                      isPassField: true,
                      isPassVisible: isConfirmPassVisible,
                      callBack: (){
                        isConfirmPassVisible = !isConfirmPassVisible;
                        ss((){});
                      },
                      hint: "Enter your password again",
                      label: "Confirm Password",
                    ),
                  );
                }
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

                    }, child: Text('Sign Up')),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text.rich(TextSpan(
                      text: "Already have an account, ",
                      children: [
                        TextSpan(text: "Login now..", style: TextStyle(
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
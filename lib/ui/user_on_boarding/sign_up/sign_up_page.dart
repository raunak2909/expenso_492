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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hi, Create Account!", style: TextStyle(fontSize: 34)),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value){

                    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                    if(value==null || value.isEmpty){
                      return "Please fill your email"; /// error msg
                    } else if(!emailRegExp.hasMatch(value)){
                      return "Please enter a valid format email";
                    } else {
                      return null; /// no error
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: mFieldDecor(
                    hint: "Enter your email here",
                    label: "Email",
                  ),
                ),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please fill your name"; /// error msg
                    } else {
                      return null; /// no error
                    }
                  },
                  controller: nameController,
                  decoration: mFieldDecor(
                    hint: "Enter your name here",
                    label: "Name",
                  ),
                ),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please fill your Mobile no"; /// error msg
                    } else if(value.length!=10){
                      return "Please enter a valid mobile no of 10 digits";
                    } else {
                      return null; /// no error
                    }
                  },
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
                    return TextFormField(
                      validator: (value){
                        RegExp passRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                        if(value==null || value.isEmpty){
                          return "Please fill your password"; /// error msg
                        } else if(!passRegex.hasMatch(value)){
                          return "Password must contain\nat-least 1 Upper case,\nat_least 1 Lower case,\nat-least 1 number,\nat-least 1 special character,\nand must be 8 characters long.";
                        } else {
                          return null; /// no error
                        }
                      },
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
                    return TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Please re-enter your password"; /// error msg
                        } else if(value!=passController.text){
                          return "Password doesn't match!!";
                        } else {
                          return null; /// no error
                        }
                      },
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

                        if(formKey.currentState!.validate()){
                          /// do your work here
                        }

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
      ),
    );
  }
}
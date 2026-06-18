import 'package:expenso_492/domain/ui_helper/input_field_decoration.dart';
import 'package:expenso_492/ui/user_on_boarding/bloc/user_bloc.dart';
import 'package:expenso_492/ui/user_on_boarding/bloc/user_event.dart';
import 'package:expenso_492/ui/user_on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/app_routes.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLogin = true;


  ///session maintain
  ///user profile UI
  ///load the current user data
  ///and apply logout feature
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
                Text("Hi, Welcome back!", style: TextStyle(fontSize: 34)),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value) {
                    RegExp emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );

                    if (value == null || value.isEmpty) {
                      return "Please fill your email";

                      /// error msg
                    } else if (!emailRegExp.hasMatch(value)) {
                      return "Please enter a valid format email";
                    } else {
                      return null;

                      /// no error
                    }
                  },
                  controller: emailController,
                  decoration: mFieldDecor(
                    hint: "Enter your email here",
                    label: "Email",
                  ),
                ),
                SizedBox(height: 11),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill your Password";

                      /// error msg
                    } else {
                      return null;

                      /// no error
                    }
                  },
                  obscureText: true,
                  controller: passController,
                  decoration: mFieldDecor(
                    hint: "Enter your password here",
                    label: "Password",
                  ),
                ),
                SizedBox(height: 11),
                BlocConsumer<UserBloc, UserState>(
                  buildWhen: (ps, cs){
                    return isLogin;
                  },
                  listenWhen: (ps, cs){
                    return isLogin;
                  },
                  listener: (_, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                    }

                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMsg),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    if (state is UserSuccessState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Logged-in Successfully!!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.DASHBOARD_PAGE,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade200,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            /// apply the login code here
                            isLogin = true;
                            context.read<UserBloc>().add(
                              UserLoginEvent(
                                email: emailController.text,
                                pass: passController.text,
                              ),
                            );
                          }
                        },
                        child: Text('Login'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 5),
                Center(
                  child: InkWell(
                    onTap: () {
                      isLogin = false;
                      Navigator.pushNamed(context, AppRoutes.SIGNUP_PAGE);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account, ",
                        children: [
                          TextSpan(
                            text: "Create now..",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
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

import 'package:flutter/material.dart';

class NavHomePage extends StatelessWidget {
  const NavHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Center(
        child: Text('Home', style: TextStyle(
          fontSize: 30,
          color: Colors.black38
        ),),
      ),
    );
  }
}

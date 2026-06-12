import 'package:flutter/material.dart';

class NavStatsPage extends StatelessWidget {
  const NavStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
        child: Text('Stats', style: TextStyle(
            fontSize: 30,
            color: Colors.black38
        ),),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Text('Home page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newHabit');
        },
        backgroundColor: const AppColors().secondaryColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

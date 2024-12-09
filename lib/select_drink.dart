import 'package:flutter/material.dart';

class SelectDrink extends StatefulWidget {
  @override
  _SelectDrinkState createState() => _SelectDrinkState();
}

class _SelectDrinkState extends State<SelectDrink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Drink'),
      ),
      body: Center(
        child: Text('Select your favorite drink!'),
      ),
    );
  }
}
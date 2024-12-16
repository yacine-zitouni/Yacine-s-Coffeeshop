import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yacine_coffeeshop/repository/coffeeshop_repo.dart';
import 'package:yacine_coffeeshop/repository/repository.dart'; 
import 'package:yacine_coffeeshop/views/home_page.dart';
import 'package:yacine_coffeeshop/views/order_page.dart';

void main() {
  GetIt.instance.registerSingleton<Repository>(CoffeeshopRepo());
  //GetIt.instance.registerSingleton<ShopPresenter>(ShopPresenterImpl());
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Order',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/order': (context) => const OrderPage(),
      },

    );
  }
}

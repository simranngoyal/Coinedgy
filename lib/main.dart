import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: const Color.fromARGB(255, 6, 35, 32),
          scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
}

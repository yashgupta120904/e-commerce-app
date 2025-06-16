import 'package:ecommerce_app/Features/screens/auth_screen.dart';
import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:ecommerce_app/routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: GlobalVariables.secondaryColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home:const AuthScreen() ,
          
    );
  }
}

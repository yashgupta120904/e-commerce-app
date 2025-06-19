import 'package:ecommerce_app/Features/auth/screens/auth_screen.dart';
import 'package:ecommerce_app/Features/auth/services/auth_service.dart';
import 'package:ecommerce_app/Features/home/home_screen.dart';

import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:ecommerce_app/routers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

@override
void initState() {
  super.initState();
  Future.microtask(() {
    authService.getUserData(context: context);
  });
}

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
      onGenerateRoute: (settings) => generateRoute(settings), //for routes
      home:Provider.of<UserProvider>(context).user.token.isNotEmpty ? const HomeScreen() : const AuthScreen(),
    );
  }
}



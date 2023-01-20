import 'package:flutter/material.dart';
import 'package:todo/features/authentication/screens/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register': (ctx) {
          return RegisterScreen();
        },
      },
      initialRoute: '/register',
    );
  }
}

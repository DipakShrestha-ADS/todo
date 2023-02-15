import 'package:flutter/material.dart';
import 'package:todo/features/authentication/screens/login_screen.dart';
import 'package:todo/features/authentication/screens/register_screen.dart';
import 'package:todo/features/dashboard/screens/home_page.dart';
import 'package:todo/features/dashboard/widgets/user_details_card.dart';
import 'package:todo/splash/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/register': (ctx) {
          return RegisterScreen();
        },
        '/home': (ctx) {
          return HomePage();
        },
        '/profile': (ctx) {
          return UserDetailsCard();
        },
        '/login': (ctx) {
          return LoginScreen();
        },
        '/splash': (ctx) {
          return SplashScreen();
        },
      },
      initialRoute: '/splash',
    );
  }
}

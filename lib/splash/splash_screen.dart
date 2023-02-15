import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      final token = sp.getString('Token');
      print("token: $token");
      if (token == null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      } else {
        final isExpired = Jwt.isExpired(token);
        if (isExpired) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, '/login');
          });
        } else {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, '/home');
          });
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              color: Colors.deepPurpleAccent,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Setting up our system, please wait...',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

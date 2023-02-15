import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/authentication/services/firebase_auth_service.dart';
import 'package:todo/features/authentication/services/firebase_firestore_service.dart';
import 'package:todo/features/authentication/widgets/custom_form_field.dart';
import 'package:todo/features/authentication/widgets/custom_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget getVerticalSpacing({double? height}) => SizedBox(
        height: height ?? 20,
      );
  bool obscureText = true;
  bool isChecked = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final firebaseAuthService = FirebaseAuthService();
  final firebaseFirestoreService = FirebaseFirestoreService();

  String? emailValidator(String? email) {
    if (email == null) {
      return 'Email is required';
    }
    if (email.isEmpty) {
      return 'Email must not be empty';
    }
    if (email.contains('@') & email.contains('.')) {
      return null;
    } else {
      return 'Email is invalid';
    }
  }

  String? passwordValidator(String? password) {
    if (password == null) {
      return 'Password is required';
    }
    if (password.isEmpty) {
      return 'Password must not be empty';
    }
    if (password.length >= 6) {
      return null;
    } else {
      return 'Password must be of length 6 or more';
    }
  }

  Future<void> login() async {
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
      try {
        final email = emailController.text;
        final password = passwordController.text;
        print('email: $email');
        CustomLoader.showMyLoader(context);

        final userCred = await firebaseAuthService.signInUser(email: email, password: password);
        Navigator.pop(context);
        final isEmailVerified = userCred.user!.emailVerified;
        print('isEmail Verified: $isEmailVerified');
        if (!isEmailVerified) {
          await userCred.user!.sendEmailVerification();
          showSnackBar(
            message: 'Your email is not verified, please verify your email first. We have sent you a verification email on your email address',
            context: context,
            backgroundColor: Colors.white,
          );
          return;
        }
        SharedPreferences sp = await SharedPreferences.getInstance();
        final token = await userCred.user!.getIdToken();
        print('token :$token');

        sp.setString('Token', token);

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) {
            return false;
          },
        );
      } on FirebaseException catch (fe) {
        print('firebase exception : ${fe.message}');
        Navigator.pop(context);
      }
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Container(
            height: 540,
            width: 500,
            padding: const EdgeInsets.all(40),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    getVerticalSpacing(),
                    CustomFormField(
                      hintText: 'E-Mail',
                      iconData: Icons.mail,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: emailValidator,
                    ),
                    getVerticalSpacing(),
                    CustomFormField(
                      hintText: 'Password',
                      iconData: Icons.key_outlined,
                      obscureText: obscureText,
                      controller: passwordController,
                      onPressedEye: () {
                        print('eye pressed');
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      validator: passwordValidator,
                    ),
                    getVerticalSpacing(
                      height: 30,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent,
                            Colors.indigoAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Builder(builder: (context) {
                        return MaterialButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          onPressed: login,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          splashColor: Colors.white.withOpacity(
                            0.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              40,
                            ),
                          ),
                        );
                      }),
                    ),
                    getVerticalSpacing(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/register');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar({
    required String message,
    required BuildContext context,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.deepPurpleAccent,
          ),
        ),
        backgroundColor: backgroundColor ?? Colors.white,
      ),
    );
  }
}

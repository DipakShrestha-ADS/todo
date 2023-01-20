import 'package:flutter/material.dart';
import 'package:todo/features/authentication/widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Widget getVerticalSpacing({double? height}) => SizedBox(
        height: height ?? 20,
      );
  bool obscureText = true;
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
            height: 480,
            width: 500,
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                getVerticalSpacing(height: 30),
                CustomFormField(
                  hintText: 'Name',
                  iconData: Icons.account_circle_outlined,
                ),
                getVerticalSpacing(),
                CustomFormField(
                  hintText: 'E-Mail',
                  iconData: Icons.mail,
                  inputType: TextInputType.emailAddress,
                ),
                getVerticalSpacing(),
                CustomFormField(
                  hintText: 'Password',
                  iconData: Icons.key_outlined,
                  obscureText: obscureText,
                  onPressedEye: () {
                    print('eye pressed');
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

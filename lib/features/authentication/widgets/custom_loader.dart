import 'package:flutter/material.dart';

class CustomLoader {
  static Future<dynamic> showMyLoader(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (ctx) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(ctx);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: GestureDetector(
                onTap: () {
                  print('loader clicked');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

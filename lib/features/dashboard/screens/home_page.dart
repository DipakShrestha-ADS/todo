import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/authentication/services/firebase_firestore_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userCredential = ModalRoute.of(context)?.settings.arguments as UserCredential;
    // print('usercred: ${userCredential.user!.uid}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Home',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestoreService().getAllUsersStream(),
        builder: (ctx, dataSnap) {
          ///is data actually getting
          if (dataSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }

          if (dataSnap.hasData) {
            final userList = dataSnap.data ?? [];
            print('user list in future builder: $userList');
            return ListView.separated(
              itemCount: userList.length,
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemBuilder: (ctx, index) {
                final user = userList[index];
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      user.fullName ?? 'N/A',
                    ),
                    subtitle: Text(
                      user.email ?? 'N/A',
                    ),
                  ),
                );
              },
            );
          }

          if (dataSnap.hasError) {
            final error = dataSnap.error;
            print('error in future builder : $error');
            return const Center(
              child: Text(
                'Error!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'No Data!',
            ),
          );
        },
      ),
    );
  }
}

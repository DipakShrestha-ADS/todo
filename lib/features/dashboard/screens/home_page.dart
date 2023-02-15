import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/authentication/services/firebase_firestore_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/profile');
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestoreService().getAllUsersStream(),
        builder: (ctx, dataSnap) {
          if (dataSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }

          if (dataSnap.hasData) {
            final userList = dataSnap.data ?? [];
            print('user list: $userList');
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
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
                  ),
                ),
              ],
            );
          }

          if (dataSnap.hasError) {
            final error = dataSnap.error;
            print('error in future: $error');
            return const Center(
              child: Text(
                'Error!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }
          return const Center(
            child: Text('No Data!'),
          );
        },
      ),
    );
  }
}

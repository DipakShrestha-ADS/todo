import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/authentication/services/firebase_auth_service.dart';
import 'package:todo/features/authentication/widgets/custom_loader.dart';
import 'package:todo/features/dashboard/services/firebase_storage_service.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('User Details'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                CustomLoader.showMyLoader(context);
                await FirebaseAuthService().logoutUser();
                final sp = await SharedPreferences.getInstance();
                await sp.remove('Token');
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              } catch (e) {
                print("error in login: $e");
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 280,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1675777289840-7cadbe22173b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                ),
                backgroundColor: Colors.deepPurpleAccent,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      print('clicked');
                      await FirebaseStorageService().deleteImage(
                        "https://firebasestorage.googleapis.com/v0/b/kashyabgroup.appspot.com/o/images%2Fcomapny-registration-form.jpeg?alt=media&token=c56ed963-7533-4018-a25a-2cbb93fc5e93",
                      );
                      print('image deleted');
                      return;
                      final imagePicker = ImagePicker();
                      final imageFile = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (imageFile != null) {
                        final imageName = imageFile.name;
                        print('image name: $imageName');
                        final imageData = await imageFile.readAsBytes();
                        final imageUrl = await FirebaseStorageService().uploadImageAndGetUrl(
                          imageData,
                          imageName: imageName,
                        );
                        print('image url: $imageUrl');
                      } else {
                        print('Cannot picked image!');
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Full Name',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/features/dashboard/services/firebase_storage_service.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('User Details'),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 280,
                width: 280,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1675777289840-7cadbe22173b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                ),
                radius: 100,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      print('add clicked');
                      final imagePicker = ImagePicker();
                      final imageFile = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (imageFile != null) {
                        final imageName = imageFile.name;
                        print('image name: $imageName');
                        final imageData = await imageFile.readAsBytes();
                        final imageUrl = await FirebaseStorageService().uploadImageAndGetUrl(
                          imageData,
                          imageName: imageName,
                        );
                        print('image url: $imageUrl');
                      } else {
                        print('image not picked!');
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(
                        Icons.add,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Full Name',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
*/

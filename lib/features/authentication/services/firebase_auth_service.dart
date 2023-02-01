import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final firebaseAuthInstance = FirebaseAuth.instance;

  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    final userCred = await firebaseAuthInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred;
  }
}

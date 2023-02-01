import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/authentication/models/user_model.dart';

class FirebaseFirestoreService {
  final firestoreInstance = FirebaseFirestore.instance;
  final userCollectionPath = 'users';
  Future<void> storeUser(UserModel userModel) async {
    final userCollectionRef = firestoreInstance.collection(userCollectionPath);
    await userCollectionRef.doc().set(userModel.toJson());
  }
}

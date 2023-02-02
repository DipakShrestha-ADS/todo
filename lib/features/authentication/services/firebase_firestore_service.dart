import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/authentication/models/user_model.dart';

class FirebaseFirestoreService {
  final firestoreInstance = FirebaseFirestore.instance;
  final userCollectionPath = 'users';
  Future<void> storeUser(UserModel userModel) async {
    final userCollectionRef = firestoreInstance.collection(userCollectionPath);
    await userCollectionRef.doc().set(userModel.toJson());
  }

  Future<void> updateUser({required UserModel userModel, required String id}) async {
    final uColRef = firestoreInstance.collection(userCollectionPath);
    await uColRef.doc(id).update(userModel.toJson());
  }

  Future<void> deleteUser({required String id}) async {
    final uColRef = firestoreInstance.collection(userCollectionPath);
    await uColRef.doc(id).delete();
  }

  Future<UserModel> getUserDetails({required String id}) async {
    final uColRef = firestoreInstance.collection(userCollectionPath);
    final userDetailsDocSnap = await uColRef.doc(id).get();
    final userDetail = userDetailsDocSnap.data();
    return UserModel.fromJson(userDetail ?? {});
  }

  Future<List<UserModel>> getAllUsers() async {
    final userCollectionRef = firestoreInstance.collection(userCollectionPath);
    final allUserQuerySnap = await userCollectionRef.get();
    final allUsers = allUserQuerySnap.docs.map((qds) {
      final data = qds.data();
      return UserModel.fromJson(data);
    }).toList();
    return allUsers;
  }

  Stream<List<UserModel>> getAllUsersStream() {
    final userCollectionRef = firestoreInstance.collection(userCollectionPath);
    final allUserQuerySnap = userCollectionRef.snapshots();
    final allUsers = allUserQuerySnap.map((event) {
      return event.docs.map((e) {
        final data = e.data();
        return UserModel.fromJson(data);
      }).toList();
    });
    return allUsers;
  }
}

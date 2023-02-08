import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final fsInstance = FirebaseStorage.instance;

  Future<String> uploadImageAndGetUrl(
    Uint8List imageData, {
    required String imageName,
  }) async {
    final folderRef = fsInstance.ref('images/$imageName');
    final uploadTask = folderRef.putData(
      imageData,
      SettableMetadata(
        contentType: imageName.split('.').last,
      ),
    );
    final imageUrl = await uploadTask.then((taskSnap) {
      return taskSnap.ref.getDownloadURL();
    });
    return imageUrl;
  }

  Future<void> deleteImage(String imageUlr) async {
    final ref = fsInstance.refFromURL(imageUlr);
    await ref.delete();
  }
}

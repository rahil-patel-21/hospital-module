import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Auth {
  Auth._();

  static Future<String> uploadPhoto(File targetFile) async {
    if (targetFile == null) {
      return null;
    } else {
      Reference _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().microsecondsSinceEpoch}');
      UploadTask _storageUploadTask = _storageReference.putFile(targetFile);
      return await _storageUploadTask
          .then((value) => value.ref.getDownloadURL());
    }
  }
}

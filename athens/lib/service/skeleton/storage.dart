import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static final Reference _storage = FirebaseStorage.instance.ref();

  static Future<void> uploadImage(String path, File file) async {
    await _storage
        .child(path)
        .putFile(file, SettableMetadata(contentType: 'image/jpeg'))
        .timeout(Duration(seconds: 30));
  }

  static Future<String> getImageURL(String path) async {
    try {
      return await _storage.child('$path.jpg').getDownloadURL();
    } catch (e) {
      try {
        return await _storage.child('$path.jpeg').getDownloadURL();
      } catch (e) {
        try {
          return await _storage.child('$path.webp').getDownloadURL();
        } catch (e) {
          return await _storage.child('$path.png').getDownloadURL();
        }
      }
    }
  }
}

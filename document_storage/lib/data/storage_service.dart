import 'dart:io';

import 'package:document_storage/data/auth_service.dart';
import 'package:document_storage/utility/utilities.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String?> uploadFile(String filePath) async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      final userStorage = FirebaseStorage.instance.ref().child(user.uid);
      final fileName = getFileName(filePath);
      final fileStorage = userStorage.child(fileName);
      try {
        final file = File(filePath);
        await fileStorage.putFile(file);
        return fileName;
      } on FirebaseException catch (error) {
        return null;
      }
    }
  }

  Future<List<String>> getAllFiles() async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      try {
        final userStorage = FirebaseStorage.instance.ref().child(user.uid);
        final result = await userStorage.listAll();
        return result.items.map((e) => e.name).toList();
      } catch (error) {
        return List<String>.empty();
      }
    } else {
      return List<String>.empty();
    }
  }

  Future<bool> deleteFile(String fileName) async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      final userStorage = FirebaseStorage.instance.ref().child(user.uid);
      final fileStorage = userStorage.child(fileName);
      try {
        await fileStorage.delete();
        return true;
      } catch (error) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<String?> getUrl(String fileName) async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      final userStorage = FirebaseStorage.instance.ref().child(user.uid);
      final fileStorage = userStorage.child(fileName);
      return await fileStorage.getDownloadURL();
    } else {
      return null;
    }
  }
}

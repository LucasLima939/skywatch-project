import 'dart:io';

abstract class FirebaseDrive {
  Future<String> uploadVideo(File file, String filePath);
  Future<bool> writeData(Map<String, dynamic> data, String refs, String uid);
  Future<Map<String, dynamic>> readAllData(String refs);
  Future<bool> updateList(String key, String value, String refs, String uid, {required bool shouldRemoveElement});
  Future<String?> signInAnonymously();
}

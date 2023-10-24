import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skywatch_application/domain/interfaces/drivers/firebase_drive.dart';

class FirebaseAdapter implements FirebaseDrive {
  @override
  Future<String> uploadVideo(File file, String filePath) async {
    final uploadTask = FirebaseStorage.instance.ref().child(filePath).putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<Map<String, dynamic>> readAllData(String refs) async => await FirebaseFirestore.instance
      .collection('videos')
      .get()
      .then((data) => {'data': data.docs.map((doc) => doc.data()).toList()});

  @override
  Future<bool> updateList(String key, String value, String refs, String uid, {required bool shouldRemoveElement}) async =>
      await FirebaseFirestore.instance.collection(refs).doc(uid).update({
        key: shouldRemoveElement ? FieldValue.arrayRemove([value]) : FieldValue.arrayUnion([value])
      }).then((value) => true);

  @override
  Future<bool> writeData(Map<String, dynamic> data, String refs, String uid) async =>
      await FirebaseFirestore.instance.collection(refs).doc(uid).update(data).then((value) => true);

  @override
  Future<String?> signInAnonymously() async =>
      await FirebaseAuth.instance.signInAnonymously().then((credential) => credential.user?.uid);
}

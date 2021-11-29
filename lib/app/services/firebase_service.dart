import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirebaseService {
  FirebaseService._();
  static final instance = FirebaseService._();

  Future<void> setData({
    required String? jobID,
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (jobID != null) {
        // Edit Job
        DocumentReference<Map<String, dynamic>> _document =
            FirebaseFirestore.instance.doc(path);
        print('$path : $data');
        await _document.set(data);
      } else {
        // Create Job
        CollectionReference<Map<String, dynamic>> _document =
            FirebaseFirestore.instance.collection(path);
        print('$path : $data');
        await _document.add(data);
      }
    } on FirebaseException catch (e) {
      throw PlatformException(
          code: e.code, details: e.plugin, message: e.message);
    }
  }

  Stream<List<T>> getStreamListCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshot = reference.snapshots();
    return snapshot.map((collection) => collection.docs
        .map(
          (document) => builder(document.data(), document.id),
        )
        .toList());
  }
}

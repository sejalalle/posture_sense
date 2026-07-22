import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/posture_history.dart';

class HistoryService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Save a posture report for the current user
  Future<void> save(PostureHistory history) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("history")
        .doc(history.id)
        .set(history.toMap());
  }

  /// Get all posture history for the current user
  Stream<List<PostureHistory>> getHistory() {
    final user = auth.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return firestore
        .collection("users")
        .doc(user.uid)
        .collection("history")
        .orderBy("date", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PostureHistory.fromMap(doc.data()),
              )
              .toList(),
        );
  }

  /// Delete a history record
  Future<void> delete(String id) async {
    final user = auth.currentUser;

    if (user == null) return;

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("history")
        .doc(id)
        .delete();
  }

  /// Delete all history for the current user
  Future<void> clearHistory() async {
    final user = auth.currentUser;

    if (user == null) return;

    final snapshot = await firestore
        .collection("users")
        .doc(user.uid)
        .collection("history")
        .get();

    final batch = firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
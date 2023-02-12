import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ozare/models/history.dart';
import 'package:ozare/models/models.dart';
import 'package:ozare/models/notification.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  /// Get the user's profile
  Stream<OUser> ouserStream(String uid) {
    log('Getting user profile ...');
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => OUser.fromJson(snapshot.data()!));
  }

  /// Get the user's history
  Future<List<History>> getHistory(String uid) async {
    log('Getting user history ...');
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('history')
        .get();
    return snapshot.docs.map((doc) => History.fromJson(doc.data())).toList();
  }

  /// Get the user's notification
  Future<List<Notification>> getNotifications(String uid) async {
    log('Getting user notification ...');
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('notification')
        .get();
    return snapshot.docs
        .map((doc) => Notification.fromJson(doc.data()))
        .toList();
  }
}

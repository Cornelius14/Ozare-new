import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ozare/features/bet/models/bet.dart';
import 'package:ozare/models/history.dart';
import 'package:ozare/models/notification.dart';

class BetRepository {
  BetRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // Create new Bet in current event
  Future<void> createBet({
    required String eventId,
    required Bet bet,
    required History history,
    required Notification notification,
  }) async {
    log('BetRepository: createBet: $eventId');

    // Add history to user
    await _firestore
        .collection('users')
        .doc(bet.userId)
        .collection('history')
        .doc(history.id)
        .set(history.toJson());

    // Add bet to event
    await _firestore
        .collection('events')
        .doc(eventId)
        .collection('bets')
        .doc(bet.id)
        .set(bet.toJson());

    // add notification to user
    await _firestore
        .collection('users')
        .doc(bet.userId)
        .collection('notification')
        .doc()
        .set(notification.toJson());
  }

  // Get all bets in current event
  Stream<List<Bet>> betStream(String eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .collection('bets')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Bet.fromJson(doc.data())).toList());
  }
}

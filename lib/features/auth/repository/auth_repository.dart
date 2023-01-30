import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ozare/models/models.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  ///
  Future<OUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // after login fetch data from firestore for the user
      final doc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return OUser.fromJson(doc.data()!);
    } catch (e) {
      log("Error in signInWithEmailAndPassword (auth_reposity): $e");
      rethrow;
    }
  }

  Future<OUser> signUpWithEmailAndPassword({
    required OUser ouser,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: ouser.email,
        password: password,
      );

      ouser = ouser.copyWith(
        uid: userCredential.user!.uid,
      );
      log(ouser.toString());
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(ouser.toJson());

      return ouser;
    } catch (e) {
      log("Error in signUpWithEmailAndPassword (auth_reposity): $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log("Error in signOut (auth_reposity): $e");
      rethrow;
    }
  }

  Stream<OUser> getOwner(String uid) {
    try {
      return _firestore
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((event) => OUser.fromJson(event.data()!));
    } catch (e) {
      log("Error in getOwner (auth_reposity): $e");
      rethrow;
    }
  }
}

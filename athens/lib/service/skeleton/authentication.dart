import 'package:athens/model/user.dart';
import 'package:athens/service/skeleton/blockchain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FoodUser user = FoodUser();

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    await user.init();
  }

  Future<void> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }

  Future<void> signUp(String fullName, String email, String password) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user == null) {
      throw(400);
    }

    await user.create(fullName);

    Blockchain.generatePrivateKey(password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    user = FoodUser();
  }

  static String getAuthId() {
    return _firebaseAuth.currentUser!.uid;
  }

  static Future<String> getAuthToken() async {
    return await _firebaseAuth.currentUser!.getIdToken();
  }

  static bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }
}

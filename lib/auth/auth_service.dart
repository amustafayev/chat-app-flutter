import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return _auth.signOut();
  }

  //register user

  Future<UserCredential> signUp(String email, password) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

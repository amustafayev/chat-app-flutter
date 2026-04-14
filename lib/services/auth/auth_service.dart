import 'package:chat_app/model/user.dart';
import 'package:chat_app/services/user/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserDetailsService _userDetailsService = UserDetailsService();

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

      _userDetailsService.saveUserDetails(
        UserDetailsDto(userId: user.user!.uid, email: email),
      );

      //
      // firestore.collection('Users').doc(user.user!.uid).set({
      //   'email': email,
      //   'uid' : user.user!.uid,
      //   'createdAt': DateTime.now(),
      // });

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

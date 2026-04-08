import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {

  //firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send a message

  Future<void> sendMessage(String receiverId, message) async {

    //get current user info
    final currentUserId = _authService.getCurrentUser()!.uid;
    final currentUserEmail = _authService.getCurrentUser()!.email;
    final Timestamp timestamp = Timestamp.now();

    //create a new message




  }


  //get messages



}

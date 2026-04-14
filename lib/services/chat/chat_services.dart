import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/user/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static final CHAT_ROOM_COLLECTION = "chat_rooms";
  static final MESSAGE_COLLECTION = "messages";

  //firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final UserDetailsService _userDetailsService = UserDetailsService();

  //get user stream
  Stream<List<UserDetailsDto>> getUserStream() {
    return _userDetailsService.getUserList();
     }

  //send a message

  Future<void> sendMessage(String receiverId, messageContent) async {
    //get current user info
    final currentUserId = _authService.getCurrentUser()!.uid;
    final currentUserEmail = _authService.getCurrentUser()!.email;
    final Timestamp timestamp = Timestamp.now();

    //create a new message

    Message message = Message(
      senderId: currentUserId,
      senderEmail: currentUserId,
      receiverId: receiverId,
      message: messageContent,
      timestamp: timestamp,
    );

    String roomId = createRoomId(currentUserId, receiverId);

    await firestore
        .collection(CHAT_ROOM_COLLECTION)
        .doc(roomId)
        .collection(MESSAGE_COLLECTION)
        .add(message.toMap());
  }

  Stream<QuerySnapshot> getMessages(String currentUserId, otherUserId) {
    String chatRoom = createRoomId(currentUserId, otherUserId);

    return firestore
        .collection(CHAT_ROOM_COLLECTION)
        .doc(chatRoom)
        .collection(MESSAGE_COLLECTION)
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  String createRoomId(String currentUserId, String receiverId) {
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    return ids.join("_");
  }

  //get messages
}

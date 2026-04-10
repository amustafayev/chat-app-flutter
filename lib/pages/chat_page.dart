import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/textfields.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String email;
  final String chatUserId;

  ChatPage({super.key, required this.email, required this.chatUserId});

  final TextEditingController _messageController = TextEditingController();
  final ChatServices chatServices = ChatServices();
  final AuthService authService = AuthService();

  void sendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }
    chatServices.sendMessage(chatUserId, _messageController.text);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(email),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          //Display all messages
          Expanded(child: _buildMessageList()),

          //user input
          buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String sender = authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: chatServices.getMessages(sender, chatUserId),
      builder: (context, snapshot) {
        //errors

        if (snapshot.hasError) {
          return Text("Error happened");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }

        //data
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              hintText: "Type a message...",
              obscureText: false,
              inputController: _messageController,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/drawer.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: MyDrawer(),

      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        //
        return ListView(
          //TODO: ListView.builder() use instead
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
    UserDetailsDto userData,
    BuildContext context,
  ) {
    //display all users except current user

    if (userData.email != _authService.getCurrentUser()!.email) {
      return UserTile(
        username: userData.email,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                email: userData.email,
                chatUserId: userData.userId,
              ),
            ),
          );
        },
      );
    }
    return Container();
  }
}

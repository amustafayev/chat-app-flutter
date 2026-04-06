import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() async {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          //Logout button
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}

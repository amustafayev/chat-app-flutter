import 'package:flutter/material.dart';

class AccountProfile extends StatelessWidget {
  const AccountProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Text("Detail 1"),
          Text("Detail 2"),
        ],
      ),
    );
  }
}

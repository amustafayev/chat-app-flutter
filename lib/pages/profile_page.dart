import 'package:chat_app/components/custome_text.dart';
import 'package:chat_app/components/profile_picture.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/user/user_service.dart';
import 'package:flutter/material.dart';

class AccountProfile extends StatefulWidget {
  AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  final AuthService _authService = AuthService();
  final UserDetailsService userDetailsService = UserDetailsService();

  UserDetailsDto? _userDto;

  void updateUserPPicture(String userId, String downloadUrl) async {

    await userDetailsService.saveUserProfilePicture(userId, downloadUrl);

    setState(() {
      _userDto!.profilePicUrl = downloadUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    var currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      userDetailsService.getUserDetails(currentUser.uid).then((userDto) {
        setState(() {
          _userDto = userDto;
        });
      });
    }
  }

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: buildUserDetails(_userDto),
      ),
    );
  }

  List<Widget> buildUserDetails(UserDetailsDto? userDto) {
    if (userDto == null) return [Text("Loading...")];

    return [
      Center(
        child: ProfilePicture(
          imageUrl: _userDto!.profilePicUrl,
          userId: _userDto!.userId,
          onImageUpload: updateUserPPicture,
        ),
      ),
      SizedBox(height: 25),
      CustomText(text: "Detail 1"),
      CustomText(text: "Detail 2"),
    ];
  }



}

import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/buttons.dart';
import 'package:chat_app/components/textfields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function()? toggleRegister;

  LoginPage({super.key, required this.toggleRegister});

  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _pwInputController = TextEditingController();

  //login method
  void login(BuildContext context) async {
    //Authenticate user
    var authService = AuthService();

    try {
      var credentials = await authService.signInWithEmailPassword(
        _emailInputController.text,
        _pwInputController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(icon: Icon(Icons.error), title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(height: 20),
            //text
            Text(
              "Welcome back!",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 20),

            CustomTextField(
              hintText: "Email",
              obscureText: false,
              inputController: _emailInputController,
            ),

            SizedBox(height: 20),

            CustomTextField(
              hintText: "Password",
              obscureText: true,
              inputController: _pwInputController,
            ),

            SizedBox(height: 25),

            CustomButton(text: "Login", onTap: () => login(context)),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: toggleRegister,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

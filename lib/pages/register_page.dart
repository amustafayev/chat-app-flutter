import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/buttons.dart';
import 'package:chat_app/components/textfields.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final Function()? toggleLogin;

  RegisterPage({super.key, required this.toggleLogin});

  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _pwInputController = TextEditingController();
  final TextEditingController _confirmPwInputController =
      TextEditingController();

  //login method
  void register(BuildContext context) async {
    //Register user
    final auth = AuthService();

    try {
      var user = await auth.signUp(
        _emailInputController.text,
        _pwInputController.text,
      );

      toggleLogin?.call();

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

            CustomTextField(
              hintText: "Confirm password",
              obscureText: true,
              inputController: _confirmPwInputController,
            ),

            SizedBox(height: 25),

            CustomButton(text: "Register", onTap: () => register(context)),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: toggleLogin,
                  child: Text(
                    "Login Now",
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

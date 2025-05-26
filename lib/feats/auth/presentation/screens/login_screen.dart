import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/presentation/screens/signup_screen.dart';
import 'package:free_chat/feats/chats/ui/chat_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 135, 238),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/chat.png'),
            ),
            SizedBox(height: 32),
            buildAuthLogin(context),
          ],
        ),
      ),
    );
  }

  Widget buildAuthLogin(BuildContext ctx) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.black),
            ),
            controller: emailController,
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.black),
            ),
            controller: passwordController,
          ),
          SizedBox(height: 8),
          FilledButton(
            onPressed: () async {
              if (await FirebaseHelpers.signIn(
                emailController.text,
                passwordController.text,
              )) {
                if (ctx.mounted) {
                  Navigator.pushReplacement(
                    ctx,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                }
              }
            },
            child: Text('Login'),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () {
              Navigator.push(
                ctx,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Text(
              'Create an account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';
import 'package:free_chat/feats/auth/data/repos/signin_repo.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.onSwitchScreen});
  final void Function() onSwitchScreen;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isSigningin = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.black),
            ),
            autocorrect: false,
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
          isSigningin
              ? CircularProgressIndicator()
              : FilledButton(
                onPressed: () async {
                  setState(() {
                    isSigningin = true;
                  });

                  final user = await SigninRepo.signinRepo(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  if (user != null) {
                    UserDM.currUser = user;
                  } else {
                    setState(() {
                      isSigningin = false;
                    });
                  }
                },
                child: Text('Login'),
              ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () {
              widget.onSwitchScreen();
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

import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/presentation/widgets/login_widget.dart';
import 'package:free_chat/feats/auth/presentation/widgets/signup_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget currMode =
        isLogin
            ? LoginWidget(onSwitchScreen: onSwitchScreen)
            : SignUpWidget(onSwitchScreen: onSwitchScreen);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 135, 238),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
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
                currMode,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSwitchScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}

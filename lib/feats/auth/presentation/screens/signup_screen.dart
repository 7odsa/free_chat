import 'dart:io';

import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/chats/ui/chat_screen.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _selectedImage;
  bool isSigningup = false;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
            buildAuthSignup(context),
          ],
        ),
      ),
    );
  }

  Widget buildAuthSignup(BuildContext ctx) {
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
          buildAddImage(),
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
              labelText: "Username",
              labelStyle: TextStyle(color: Colors.black),
            ),
            controller: usernameController,
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
          buildSignUpButton(emailController, passwordController, ctx),
          SizedBox(height: 8),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              'Already have an account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignUpButton(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext ctx,
  ) {
    return !isSigningup
        ? FilledButton(
          onPressed: () async {
            setState(() {
              isSigningup = !isSigningup;
            });
            final isSigned = await FirebaseHelpers.createNewUser(
              emailController.text,
              passwordController.text,
            );
            if (isSigned) {
              if (ctx.mounted) {
                Navigator.pushReplacement(
                  ctx,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              }
            }
            setState(() {
              isSigningup = !isSigningup;
            });
          },
          child: Text('SignUp'),
        )
        : CircularProgressIndicator();
  }

  Widget buildAddImage() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color.fromARGB(255, 121, 117, 110),
          backgroundImage:
              _selectedImage != null ? FileImage((_selectedImage!)) : null,
        ),
        TextButton.icon(
          onPressed: () {
            _takePicture();
          },
          label: Text(
            'Add Image',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.image_rounded, size: 24),
        ),
      ],
    );
  }

  void _takePicture() async {
    final imgaePicker = ImagePicker();
    final pickedImage = await imgaePicker.pickImage(source: ImageSource.camera);

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }
}

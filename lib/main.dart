import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_chat/feats/auth/data/helpers/shared_pref.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';
import 'package:free_chat/feats/auth/presentation/screens/login_screen.dart';
import 'package:free_chat/feats/chats/ui/chat_screen.dart';
import 'package:free_chat/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 255, 255),
);

class _MainAppState extends State<MainApp> {
  Widget screen = const LoginScreen();
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (UserDM.currUser != null) screen = ChatScreen();
    return MaterialApp(
      theme: ThemeData().copyWith(colorScheme: colorScheme),
      home: screen,
    );
  }

  void getUser() async {
    UserDM.currUser = await SharedPref.getUser();
    if (UserDM.currUser != null) setState(() {});
  }
}

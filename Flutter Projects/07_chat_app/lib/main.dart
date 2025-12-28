import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 73, 130)),
      ),
      // This is very similar to FutureBuilder. However FutureBuilder only deals a single error. StreamBuilder uses multiple
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), // Notice that this returns a stream
        builder: (ctx, snapshot) {
          // This checks to see if Firebase is still waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          // This only happens if we have data or a "logged in user"
          if (snapshot.hasData) {
            return const ChatScreen();
          }

          return const AuthScreen();
        }
      ),
    );
  }
}
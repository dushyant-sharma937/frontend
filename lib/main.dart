import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Here we use MultiProvider to provide the NotesProvider to the entire app
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              NotesProvider(), // Create an instance of NotesProvider as the value for the provider
        ),
      ],

      // MaterialApp is the root widget of the app
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/views/add_note_view.dart';
import 'package:frontend/views/notes_view.dart';

import 'package:frontend/views/register_view.dart';
import 'package:frontend/views/login_view.dart';
import 'package:frontend/views/home_page_view.dart';
import 'package:frontend/views/splash_screen.dart';
import 'package:frontend/views/trash_notes_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': (context) => const RegisterView(),
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomePage(),
        '/notes': (context) => NoteListWidget(),
        '/trash': (context) => TrashListWidget(),
        '/add-note': (context) => AddNoteWidget(),
      },

    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/shared/shared_preferences.dart';
import 'package:frontend/views/add_note_view.dart';
import 'package:frontend/views/notes_view.dart';

import 'package:frontend/views/register_view.dart';
import 'package:frontend/views/login_view.dart';
import 'package:frontend/views/home_page_view.dart';
import 'package:frontend/views/splash_screen.dart';
import 'package:frontend/views/trash_notes_view.dart';

import 'views/avatar.dart';
import 'views/profil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isLoggedIn = await SharedPrefUtils.readIsLoggedIn();
  final initialRoute = isLoggedIn ?? false ? '/home' : '/';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': (context) => const RegisterView(),
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomePage(),
        '/notes': (context) => NoteListWidget(),
        '/trash': (context) => TrashListWidget(),
        '/add-note': (context) => AddNoteWidget(),
        '/addImage': (context) => ProfilePage(),
        '/avatar': (context) => AvatarPage(),
      },
    );
  }
}

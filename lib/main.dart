import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimilist_social_media_app/auth/auth.dart';
import 'package:minimilist_social_media_app/auth/login_or_register.dart';
import 'package:minimilist_social_media_app/pages/home_page.dart';
import 'package:minimilist_social_media_app/pages/login_page.dart';
import 'package:minimilist_social_media_app/pages/profile_page.dart';
import 'package:minimilist_social_media_app/pages/register_page.dart';
import 'package:minimilist_social_media_app/pages/user_page.dart';
import 'package:minimilist_social_media_app/theme/dark_mode.dart';
import 'package:minimilist_social_media_app/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage()
      },
    );
  }
}

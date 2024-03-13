import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimilist_social_media_app/components/my_text_field.dart';

class HomePage extends StatelessWidget {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  HomePage({super.key});

  final TextEditingController newPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("W A L L"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MyTextField(
                hintText: "Say something..",
                obscureText: false,
                controller: newPostController),
          )
        ],
      ),
    );
  }
}

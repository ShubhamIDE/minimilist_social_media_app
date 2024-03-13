import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimilist_social_media_app/components/my_list_tile.dart';
import 'package:minimilist_social_media_app/components/my_post_button.dart';
import 'package:minimilist_social_media_app/components/my_text_field.dart';
import 'package:minimilist_social_media_app/database/firestore.dart';

class HomePage extends StatelessWidget {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  HomePage({super.key});

  final FireStoreDatabase database = FireStoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    newPostController.clear();
  }

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
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Say something..",
                      obscureText: false,
                      controller: newPostController),
                ),
                PostButton(onTap: () {
                  postMessage;
                })
              ],
            ),
          ),
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: ((context, snapshot) {
                // show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final posts = snapshot.data!.docs;

                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No Posts.. Post something!"),
                    ),
                  );
                }

                return Expanded(
                    child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timeStamp = post['TimeStamp'];

                    return MyListTile(title: message, subtitle: userEmail);
                  },
                ));
              }))
        ],
      ),
    );
  }
}

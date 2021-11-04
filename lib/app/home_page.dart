import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Function onSignOut;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomePage({
    required this.onSignOut,
  });

  _signOutUser() async {
    try {
      await _auth.signOut();
      onSignOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOutUser,
          )
        ],
      ),
    );
  }
}

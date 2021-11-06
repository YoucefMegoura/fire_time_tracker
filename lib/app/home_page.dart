import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';

class HomePage extends StatelessWidget {
  final Function onSignOut;

  final AuthServiceImpl _auth = AuthServiceImpl();

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

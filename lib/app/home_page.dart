import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';

class HomePage extends StatelessWidget {
  final AuthServiceImpl auth;

  HomePage({
    required this.auth,
  });

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
      body: _bodyContent(context),
    );
  }

  _signOutUser() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Widget _bodyContent(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/models/user.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  final AuthServiceImpl auth;

  LandingPage({required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyUser?>(
        stream: auth.onChangeUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInPage(auth: auth);
            }
            return HomePage(
              auth: auth,
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

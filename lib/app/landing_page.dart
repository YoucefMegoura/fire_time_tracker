import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
  }

  void _isUserLoggedIn() {}

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      _updateUser(_auth.currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(onSignIn: _updateUser);
    }
    return HomePage(onSignOut: () => _updateUser(null));
  }
}

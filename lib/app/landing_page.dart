import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/models/user.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  MyUser? _user;
  final AuthServiceImpl _auth = AuthServiceImpl();
  void _updateUser(MyUser? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    if (_auth.getCurrentUser() != null) {
      _updateUser(_auth.getCurrentUser());
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

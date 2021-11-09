import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter/app/models/user.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_email_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_social_button.dart';

import '../constants.dart';

class SignInPage extends StatelessWidget {
  final AuthServiceImpl auth;

  SignInPage({
    required this.auth,
  });

  void _anonymousAuth() async {
    await auth.signInAnonymously();
  }

  void _googleAuth() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  void _facebookAuth() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e);
    }
  }

  void _emailAuth(BuildContext context) async {
    try {
      await Navigator.push<Map<String, String?>>(
        context,
        MaterialPageRoute<Map<String, String?>>(
          fullscreenDialog: true,
          builder: (context) => SignInEmailPage(auth),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          centerTitle: true, title: const Text('Time Tracker'), elevation: 2),
      body: _bodyContent(context),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20.0),
            SignInSocialButton(
              image: 'images/google-logo.png',
              text: 'Sign In with Google',
              onPressed: _googleAuth,
            ),
            const SizedBox(height: 10.0),
            SignInSocialButton(
              image: 'images/facebook-logo.png',
              text: 'Sign In with Facebook',
              backgroundColor: const Color(0xFF344B93),
              textColor: Colors.white,
              onPressed: _facebookAuth,
            ),
            const SizedBox(height: 10.0),
            SignInButton(
              text: 'Sign In with email',
              backgroundColor: const Color(0xFF016D60),
              textColor: Colors.white,
              onPressed: () => _emailAuth(context),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'or',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            SignInButton(
              text: 'Go anonymous',
              backgroundColor: const Color(0xFFD7E26C),
              textColor: Colors.black,
              onPressed: _anonymousAuth,
            ),
          ],
        ),
      ),
    );
  }
}

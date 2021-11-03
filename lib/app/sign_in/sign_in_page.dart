import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_social_button.dart';

class SignInPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInPage();

  void _anonymousAuth() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      print(userCredential.user!.displayName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          centerTitle: true, title: const Text('Time Tracker'), elevation: 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Sign In',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20.0),
              SignInSocialButton(
                image: 'images/google-logo.png',
                text: 'Sign In with Google',
                onPressed: () {
                  //
                },
              ),
              SizedBox(height: 10.0),
              SignInSocialButton(
                image: 'images/facebook-logo.png',
                text: 'Sign In with Facebook',
                backgroundColor: const Color(0xFF344B93),
                textColor: Colors.white,
                onPressed: () {
                  //
                },
              ),
              SizedBox(height: 10.0),
              SignInButton(
                text: 'Sign In with email',
                backgroundColor: const Color(0xFF016D60),
                textColor: Colors.white,
                onPressed: () {
                  //
                },
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
                onPressed: () => _anonymousAuth(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_email_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_social_button.dart';

import '../constants.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _onAuth(BuildContext context, Function authMethod) async {
    try {
      setState(() => _isLoading = true);
      await authMethod(context);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_MISSING_GOOGLE_TOKEN' &&
          e.code != 'ERROR_MISSING_FACEBOOK_TOKEN') {
        _showErrorDialog(context: context, exception: e);
        setState(() => _isLoading = false);
      }
      print(e);
    } finally {
      if (authMethod == _emailAuth) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(
      {String title = 'Sign in Failed',
      required PlatformException exception,
      required BuildContext context}) {
    PlatformExceptionAlertDialog(
      title: title,
      exception: exception,
    ).show(context);
  }

  void _anonymousAuth(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    await authProvider.signInAnonymously();
  }

  void _googleAuth(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    await authProvider.signInWithGoogle();
  }

  void _facebookAuth(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    await authProvider.signInWithFacebook();
  }

  void _emailAuth(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute<Map<String, String?>>(
        fullscreenDialog: true,
        builder: (context) => SignInEmailPage(),
      ),
    );
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
            _buildHeader(),
            const SizedBox(height: 20.0),
            SignInSocialButton(
              image: 'images/google-logo.png',
              text: 'Sign In with Google',
              onPressed: () => _onAuth(context, _googleAuth),
              backgroundColor: Colors.white,
              isEnable: !_isLoading,
            ),
            const SizedBox(height: 10.0),
            SignInSocialButton(
              image: 'images/facebook-logo.png',
              text: 'Sign In with Facebook',
              backgroundColor: const Color(0xFF344B93),
              textColor: Colors.white,
              onPressed: () => _onAuth(context, _facebookAuth),
              isEnable: !_isLoading,
            ),
            const SizedBox(height: 10.0),
            SignInSocialButton(
              text: 'Sign In with email',
              backgroundColor: const Color(0xFF016D60),
              textColor: Colors.white,
              onPressed: () => _onAuth(context, _emailAuth),
              isEnable: !_isLoading,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'or',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            SignInSocialButton(
              text: 'Go anonymous',
              backgroundColor: const Color(0xFFD7E26C),
              textColor: Colors.black,
              onPressed: () => _onAuth(context, _anonymousAuth),
              isEnable: !_isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.indigoAccent,
        ),
      );
    }
    return const Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500),
    );
  }
}

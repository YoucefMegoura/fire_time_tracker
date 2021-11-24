import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/validators.dart';

import '../constants.dart';

enum SignEmailType { signIn, signUp }

class SignInEmailPage extends StatefulWidget with EmailAndPasswordValidator {
  @override
  _SignInEmailPageState createState() => _SignInEmailPageState();
}

class _SignInEmailPageState extends State<SignInEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  SignEmailType _formType = SignEmailType.signIn;
  bool _isFormSubmitted = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Email SignIn'),
      ),
      body: SingleChildScrollView(child: _bodyContent(context)),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _bodyContent(BuildContext context) {
    String _textButton =
        (_formType == SignEmailType.signIn) ? 'Sign In' : 'Sign Up';
    String _textString = (_formType == SignEmailType.signIn)
        ? 'Do you want to Sign Up'
        : 'Do you want to Sign In';

    bool _isFormValid = widget.emailValidator.isNotEmptyValidation(_email) &&
        widget.passwordValidator.isNotEmptyValidation(_password);

    List<Widget> _buildChildren() {
      return [
        _emailTextField(),
        const SizedBox(
          height: 12.0,
        ),
        _passwordTextField(),
        const SizedBox(
          height: 12.0,
        ),
        GestureDetector(
          onTap: _toggleForm,
          child: Text(_textString),
        ),
        const SizedBox(
          height: 12.0,
        ),
        SignInButton(
          //TODO:: create a formSignIn Button extends CustomRaisedButton
          backgroundColor: Colors.indigoAccent,
          textColor: Colors.white,
          text: _textButton,
          onPressed: _isFormValid && !_isLoading ? _submit : null,
          isEnable: !_isLoading || _isFormValid,
        )
      ];
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          ),
        ),
      ),
    );
  }

  TextField _passwordTextField() {
    bool _showPasswordError = _isFormSubmitted &&
        !widget.passwordValidator.isNotEmptyValidation(_password);

    return TextField(
      enabled: !_isLoading,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText:
            _showPasswordError ? widget.passwordEmptyErrorValidator : null,
      ),
      onChanged: (value) => _updateState(),
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      onEditingComplete: _onCompletePasswordEditing,
    );
  }

  TextField _emailTextField() {
    bool _showEmailError =
        _isFormSubmitted && !widget.emailValidator.isNotEmptyValidation(_email);
    return TextField(
      enabled: !_isLoading,
      decoration: InputDecoration(
        hintText: 'example@email.com',
        labelText: 'Email',
        errorText: _showEmailError ? widget.emailEmptyErrorValidator : null,
      ),
      onChanged: (value) => _updateState(),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      controller: _emailController,
      focusNode: _emailFocusNode,
      onEditingComplete: _onCompleteEmailEditing,
    );
  }

  void _submit() async {
    final authProvider = context.read<AuthService>();

    setState(() {
      _isLoading = true;
      _isFormSubmitted = true;
    });
    try {
      if (_formType == SignEmailType.signIn) {
        await authProvider.createUserWithEmailAndPassword(_email, _password);
      } else {
        await authProvider.signInWithEmailAndPassword(_email, _password);
      }

      Navigator.pop(context);
    } on PlatformException catch (error) {
      const String errorTitle = 'Authentication Error';
      PlatformExceptionAlertDialog(
        title: errorTitle,
        exception: error,
      ).show(context);
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleForm() {
    if (!_isLoading) {
      setState(() {
        _formType = (_formType == SignEmailType.signIn)
            ? SignEmailType.signUp
            : SignEmailType.signIn;

        _emailController.clear();
        _passwordController.clear();
      });
    }
  }

  void _onCompleteEmailEditing() {
    var _newFocus = widget.emailValidator.isNotEmptyValidation(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(_newFocus);
  }

  void _onCompletePasswordEditing() {
    _submit();
  }

  void _updateState() {
    setState(() {});
  }
}

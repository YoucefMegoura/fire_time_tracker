import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Color? textColor,
    required Function? onPressed,
    required String text,
    Color? backgroundColor,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: textColor ?? Colors.black),
          ),
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          borderRadius: 8,
        );
}

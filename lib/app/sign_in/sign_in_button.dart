import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton(
      {Color? textColor,
      required Function? onPressed,
      required String text,
      Color? backgroundColor,
      bool isEnable = true})
      : super(
            child: Text(
              text,
              style: TextStyle(color: textColor ?? Colors.black),
            ),
            onPressed: onPressed,
            backgroundColor: isEnable ? backgroundColor : Colors.grey,
            borderRadius: 8,
            isEnable: isEnable);
}

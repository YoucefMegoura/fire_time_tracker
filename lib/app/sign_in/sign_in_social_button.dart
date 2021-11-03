import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/common_widgets/custom_raised_button.dart';

class SignInSocialButton extends CustomRaisedButton {
  SignInSocialButton(
      {Color? textColor,
      required Function onPressed,
      required String text,
      Color? backgroundColor,
      required String image})
      : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
              ),
              Text(
                text,
                style: TextStyle(color: textColor ?? Colors.black),
              ),
              const SizedBox()
            ],
          ),
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          borderRadius: 8,
        );
}

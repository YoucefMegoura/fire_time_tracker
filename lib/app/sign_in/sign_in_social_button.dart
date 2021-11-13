import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/common_widgets/custom_raised_button.dart';

class SignInSocialButton extends CustomElevatedButton {
  SignInSocialButton(
      {Color? textColor,
      required Function onPressed,
      required String text,
      Color? backgroundColor,
      String? image,
      bool isEnable = true})
      : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageAsset(image),
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
          isEnable: isEnable,
        );

  static Widget _buildImageAsset(String? imageAsset) {
    if (imageAsset == null) {
      return const SizedBox();
    }
    return Image.asset(imageAsset);
  }
}

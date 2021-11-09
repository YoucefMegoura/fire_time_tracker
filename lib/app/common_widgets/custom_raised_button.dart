import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Function? onPressed;
  final Widget child;
  final double? height;
  final double? borderRadius;
  CustomRaisedButton(
      {this.backgroundColor = Colors.white,
      required this.child,
      required this.onPressed,
      this.height,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
          ),
        ),
        child: child,
        onPressed: () {
          if (onPressed == null) {
            return;
          }
          onPressed!();
        },
      ),
    );
  }
}

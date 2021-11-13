import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Function? onPressed;
  final Widget child;
  final double? height;
  final double? borderRadius;
  final bool isEnable;

  CustomElevatedButton(
      {this.backgroundColor = Colors.white,
      required this.child,
      required this.onPressed,
      this.height,
      this.borderRadius,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
          ),
        ),
        child: child,
        onPressed: () {
          if (!isEnable || onPressed == null) {
            return;
          }
          onPressed!();
        },
      ),
    );
  }
}

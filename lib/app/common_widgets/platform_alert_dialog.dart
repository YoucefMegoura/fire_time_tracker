import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;

  PlatformAlertDialog({required this.title, required this.content});

  Future<bool?> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return this;
            })
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return this;
            });
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      PlatformDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Ok'),
      )
    ];
  }
}

class PlatformDialogAction extends PlatformWidget {
  final Function onPressed;
  final Widget child;

  PlatformDialogAction({
    required this.onPressed,
    required this.child,
  });

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: child,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: child,
    );
  }
}

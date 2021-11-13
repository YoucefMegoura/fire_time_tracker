import 'package:flutter/services.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  final String title;
  final PlatformException exception;

  PlatformExceptionAlertDialog({
    required this.title,
    required this.exception,
  }) : super(
          title: title,
          content: exception.message.toString(),
          cancelTextButton: 'OK',
        );
}

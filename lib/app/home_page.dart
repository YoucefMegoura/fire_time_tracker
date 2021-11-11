import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';

class HomePage extends StatelessWidget {
  final AuthServiceImpl auth;

  HomePage({
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showDialogToLogout(context),
          )
        ],
      ),
      body: _bodyContent(context),
    );
  }

  _signOutUser(BuildContext context) async {
    try {
      await auth.signOut();
    } catch (e) {
      const dialogTitle = 'Logout Error';
      final dialogContent = 'Cause ${e.toString()} Can you please try later ?';
      const cancelTextButton = 'Dismiss';

      PlatformAlertDialog(
        title: dialogTitle,
        content: dialogContent,
        cancelTextButton: cancelTextButton,
      ).show(context);
    }
  }

  _showDialogToLogout(BuildContext context) async {
    const dialogTitle = 'Logout';
    const dialogContent = 'Do you want to logout ?';
    const cancelTextButton = 'Dismiss';
    const agreeTextButton = 'Logout';

    bool isUserWantToLogout = await PlatformAlertDialog(
      content: dialogTitle,
      title: dialogContent,
      cancelTextButton: cancelTextButton,
      agreeTextButton: agreeTextButton,
    ).show(context);

    if (isUserWantToLogout) {
      _signOutUser(context);
    }
  }

  Widget _bodyContent(BuildContext context) {
    return Container();
  }
}

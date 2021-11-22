import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/app/models/job.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/services/database_service.dart';

class JobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showDialogToLogout(context),
          )
        ],
      ),
      body: _bodyContent(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }

  void _signOutUser(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    try {
      await authProvider.signOut();
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

  void _showDialogToLogout(BuildContext context) async {
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
    Stream<List<Job>> streamJobsList =
        context.read<DatabaseService>().streamJobs();
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
                .map((Job job) =>
                    Text(job.name + ' : ' + job.ratePerHour.toString()))
                .toList(),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('Error : No data !'));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      stream: streamJobsList,
    );
  }

  Future<void> _createJob(BuildContext context) async {
    var job = Job(
      name: 'Youcef ${Random().nextInt(100).toDouble()}',
      ratePerHour: Random().nextInt(100).toDouble(),
    );
    try {
      await context.read<DatabaseService>().createJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
      print(e);
    }
  }
}

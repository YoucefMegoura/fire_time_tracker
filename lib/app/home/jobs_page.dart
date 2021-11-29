import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter/app/home/edit_job_page.dart';
import 'package:time_tracker_flutter/app/home/job_tile_list.dart';
import 'package:time_tracker_flutter/app/models/job.dart';
import 'package:time_tracker_flutter/app/services/auth_service.dart';
import 'package:time_tracker_flutter/app/services/database_service.dart';

import 'empty_content.dart';

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

  Widget _bodyContent(BuildContext context) {
    final databaseService = context.read<DatabaseService>();
    Stream<List<Job>> streamJobsList = databaseService.streamJobs();
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListView(
              children: snapshot.data!
                  .map(
                    (Job job) => JobTileList(
                      job: job,
                      onTap: () {
                        //TODO:: REFACTOR CODE : REMOVE DUPLICATION #001#
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => EditJobPage(
                                databaseService: databaseService, job: job),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          }
          return EmptyContent(
            title: 'Nothing to show',
            message: 'There is no content, add jobs to get Started!',
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

  void _signOutUser(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    try {
      await authProvider.signOut();
    } catch (e) {
      const dialogTitle = 'Logout Error';
      final dialogContent = 'Cause $e Can you please try later ?';
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

  Future<void> _createJob(BuildContext context) async {
    //TODO:: REFACTOR CODE : REMOVE DUPLICATION #001#
    final databaseService = context.read<DatabaseService>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditJobPage(databaseService: databaseService),
      ),
    );
  }
}

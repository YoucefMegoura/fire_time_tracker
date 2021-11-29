import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/models/job.dart';

class JobTileList extends StatelessWidget {
  Job job;
  Function() onTap;
  JobTileList({required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        job.name,
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

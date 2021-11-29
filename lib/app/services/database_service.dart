import 'dart:core';
import 'dart:math';

import 'package:time_tracker_flutter/app/models/job.dart';
import 'package:time_tracker_flutter/app/services/api_path.dart';
import 'package:time_tracker_flutter/app/services/firebase_service.dart';

abstract class DatabaseService {
  Future<void> setJob(Job job);
  Stream<List<Job>> streamJobs();
}

class FirebaseDatabaseService implements DatabaseService {
  final String uid;
  FirebaseDatabaseService({required this.uid});

  @override
  Future<void> setJob(Job job) async {
    final _service = FirebaseService.instance;
    _service.setData(
      jobID: job.id,
      path: APIPath.job(uid, job.id),
      data: job.toMap(),
    );
  }

  @override
  Stream<List<Job>> streamJobs() {
    final _service = FirebaseService.instance;

    return _service.getStreamListCollection<Job>(
        path: APIPath.jobs(uid),
        builder: (data, documentID) => Job.fromMap(data, documentID));
  }
}

class APIPath {
  static String job(String uid, String? jobID) =>
      jobID == null ? 'users/$uid/jobs' : 'users/$uid/jobs/$jobID';
  static String jobs(String uid) => 'users/$uid/jobs';
}

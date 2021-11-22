class Job {
  String name;
  double ratePerHour;

  Job({required this.name, required this.ratePerHour});

  Map<String, dynamic> toMap() {
    return {'name': name, 'ratePerHour': ratePerHour};
  }

  factory Job.fromMap(Map<String, dynamic> data) {
    String name = data['name'];
    double ratePerHour = data['ratePerHour'];
    return Job(name: name, ratePerHour: ratePerHour);
  }

  @override
  String toString() {
    return 'name: $name, ratePerHour: $ratePerHour';
  }
}

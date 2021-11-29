class Job {
  String? id;
  String name;
  double ratePerHour;

  Job({required this.id, required this.name, required this.ratePerHour});

  Map<String, dynamic> toMap() {
    return {'name': name, 'ratePerHour': ratePerHour};
  }

  factory Job.fromMap(Map<String, dynamic> data, String documentID) {
    String name = data['name'];
    double ratePerHour = data['ratePerHour'];
    return Job(id: documentID, name: name, ratePerHour: ratePerHour);
  }

  @override
  String toString() {
    return 'id: $id, name: $name, ratePerHour: $ratePerHour';
  }
}

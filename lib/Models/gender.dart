class gendermodel {
  final String name;
  final String gender;
  final double probability;
  final int count;

  gendermodel({
    required this.name,
    required this.gender,
    required this.probability,
    required this.count,
  });

  factory gendermodel.fromJson(Map<String, dynamic> json) {
    return gendermodel(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'].toDouble(),
      count: json['count'],
    );
  }
}

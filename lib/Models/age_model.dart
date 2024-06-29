class AgeModel {
  final String name;
  final int age;
  final int count;

  AgeModel({
    required this.name,
    required this.age,
    required this.count,
  });

  factory AgeModel.fromJson(Map<String, dynamic> json) {
    return AgeModel(
      name: json['name'],
      age: json['age'],
      count: json['count'],
    );
  }
}

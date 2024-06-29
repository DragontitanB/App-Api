// university_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/university_model.dart';

class UniversityService {
  Future<List<University>> fetchUniversitiesByCountry(
      String countryName) async {
    final response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=$countryName'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => University.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }
}

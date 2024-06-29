import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/age_model.dart';

class AgeService {
  final String apiUrl = "https://api.agify.io/";

  Future<AgeModel> fetchAgePrediction(String name) async {
    final response = await http.get(Uri.parse('$apiUrl?name=$name'));

    if (response.statusCode == 200) {
      return AgeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

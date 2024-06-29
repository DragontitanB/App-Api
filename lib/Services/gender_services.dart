import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gender.dart'; // Asegúrate de que esta ruta sea correcta

class ApiService {
  final String apiUrl = "https://api.genderize.io/";

  Future<gendermodel> fetchData(String name) async {
    final response = await http.get(Uri.parse('$apiUrl?name=$name'));

    if (response.statusCode == 200) {
      return gendermodel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

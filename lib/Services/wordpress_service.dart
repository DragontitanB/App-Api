import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wordpress_post.dart';

class WordPressService {
  final String baseUrl =
      'https://public-api.wordpress.com/wp/v2/sites/rollingstone.wordpress.com/posts';

  Future<List<WordPressPost>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => WordPressPost.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

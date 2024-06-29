import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class WordPressNewsScreen extends StatefulWidget {
  const WordPressNewsScreen({super.key});

  @override
  _WordPressNewsScreenState createState() => _WordPressNewsScreenState();
}

class _WordPressNewsScreenState extends State<WordPressNewsScreen> {
  late Future<List<dynamic>> futurePosts;
  static const Color myCustomColor = Color(0xFFa5d6a7);

  @override
  void initState() {
    super.initState();
    futurePosts = fetchLatestPosts();
  }

  Future<List<dynamic>> fetchLatestPosts() async {
    final response = await http.get(Uri.parse(
        'https://public-api.wordpress.com/wp/v2/sites/currentworldmedia.wordpress.com/posts?per_page=3&orderby=date&order=desc'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordPress News'),
        backgroundColor: myCustomColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.green, // Background color
        ),
        child: FutureBuilder<List<dynamic>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No posts found'));
            } else {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Image.asset(
                    'assets/gtalogo.png', // Ruta del logo de la página web
                    height: 100,
                  ),
                  ...snapshot.data!.map<Widget>((post) {
                    return Card(
                      color: Colors.white, // Card background color
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        title: Text(
                          cleanText(post['title']['rendered']),
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cleanText(post['excerpt']['rendered']),
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                _launchURL(post['link']);
                              },
                              child: const Text('Read more'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String cleanText(String input) {
    final replacements = {
      RegExp(r'&amp;'): '& ', // Reemplaza &amp; con &
      RegExp(r'&#8211;'): '-', // Reemplaza &mdash; con -
      RegExp(r'&nbsp;'): '', // Remueve etiquetas HTML
      RegExp(r'<[^>]*>'): '',
      RegExp(r'&hellip;'): '...',
      RegExp(r'&#8217;'): '’',
      // Agrega más patrones y reemplazos si es necesario
    };

    replacements.forEach((pattern, replacement) {
      input = input.replaceAll(pattern, replacement);
    });

    return input;
  }

  void _launchURL(String url) async {
    Uri url2 = Uri.parse(url);
    if (!await launchUrl(url2)) {
      throw Exception('Could not launch $url2');
    }
  }
}

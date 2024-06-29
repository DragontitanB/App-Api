// university_screen.dart
import 'package:flutter/material.dart';
import '../services/university_services.dart';
import '../models/university_model.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({Key? key}) : super(key: key);

  @override
  _UniversityScreenState createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  late Future<List<University>> _futureUniversities;
  final TextEditingController _controller = TextEditingController();
  static const Color myCustomColor = Color(0xFFa5d6a7);

  @override
  void initState() {
    super.initState();
    _futureUniversities =
        UniversityService().fetchUniversitiesByCountry('Dominican Republic');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universities by Country'),
        backgroundColor: myCustomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter country name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureUniversities = UniversityService()
                      .fetchUniversitiesByCountry(_controller.text);
                });
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<University>>(
              future: _futureUniversities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        University university = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            title: Text(university.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Domain: ${university.domain}'),
                                Text('Web Page: ${university.webPage}'),
                              ],
                            ),
                            onTap: () {
                              // Implementar acción al hacer tap en la universidad
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('No universities found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

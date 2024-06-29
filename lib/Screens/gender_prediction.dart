import 'package:flutter/material.dart';
import '../Services/gender_services.dart';
import '../models/gender.dart'; // Asegúrate de que esta ruta sea correcta

class GenderPredictionScreen extends StatefulWidget {
  const GenderPredictionScreen({super.key});

  @override
  _GenderPredictionScreenState createState() {
    return _GenderPredictionScreenState();
  }
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  Future<gendermodel>? _futurePrediction;
  final TextEditingController _controller = TextEditingController();
  static const Color myCustomColor = Color(0xFFa5d6a7);

  void _predictGender() {
    setState(() {
      _futurePrediction = ApiService().fetchData(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender Prediction'),
        backgroundColor: myCustomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter a name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictGender,
              child: const Text('Predict Gender'),
            ),
            const SizedBox(height: 20),
            _futurePrediction == null
                ? const Text('Enter a name to get a prediction')
                : FutureBuilder<gendermodel>(
                    future: _futurePrediction,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        gendermodel prediction = snapshot.data!;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Name: ${prediction.name}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Gender: ${prediction.gender}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            prediction.gender.toLowerCase() == 'male'
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.blue,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.pink,
                                  ),
                          ],
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

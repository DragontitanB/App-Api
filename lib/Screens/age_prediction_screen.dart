import 'package:flutter/material.dart';
import 'package:cautao_proyect/services/age_services.dart';
import '../Models/age_model.dart';

class AgePredictionScreen extends StatefulWidget {
  const AgePredictionScreen({super.key});

  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  Future<AgeModel>? _futurePrediction;
  final TextEditingController _controller = TextEditingController();
  static const Color myCustomColor = Color(0xFFa5d6a7);

  void _predictAge() {
    setState(() {
      _futurePrediction = AgeService().fetchAgePrediction(_controller.text);
    });
  }

  String _getAgeCategory(int age) {
    if (age < 18) {
      return 'Joven';
    } else if (age < 59) {
      return 'Adulto';
    } else {
      return 'Anciano';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Prediction'),
        backgroundColor: myCustomColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                onPressed: _predictAge,
                child: const Text('Predict Age'),
              ),
              const SizedBox(height: 20),
              _futurePrediction == null
                  ? const Text('Enter a name to get a prediction')
                  : FutureBuilder<AgeModel>(
                      future: _futurePrediction,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          AgeModel prediction = snapshot.data!;
                          String ageCategory = _getAgeCategory(prediction.age);
                          String imageAsset;
                          if (ageCategory == 'Joven') {
                            imageAsset = 'assets/Joven.png';
                          } else if (ageCategory == 'Adulto') {
                            imageAsset = 'assets/Adulto.png';
                          } else {
                            imageAsset = 'assets/Viejito.png';
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Name: ${prediction.name}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Age: ${prediction.age}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Category: $ageCategory',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                imageAsset,
                                height:
                                    300, // Ajusta el tamaño según sea necesario
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
      ),
    );
  }
}

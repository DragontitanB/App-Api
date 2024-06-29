import 'package:cautao_proyect/Screens/gender_prediction.dart';
import 'Screens/about_screen.dart';
import 'package:cautao_proyect/Screens/university_screen.dart';
import 'package:flutter/material.dart';
import 'package:cautao_proyect/Screens/HomeScreen.dart';
import 'Screens/age_prediction_screen.dart';
import 'Screens/weather_screen.dart';
import 'Screens/wordpress_news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(), // Página principal - HomeScreen
    const GenderPredictionScreen(), //Pagina Adivina el genero
    const AgePredictionScreen(), //Pagina Adivina la edad
    const UniversityScreen(), //Página para busqueda de universidad
    const ClimaPage(), // Página para el clima
    const WordPressNewsScreen(), // Pagina del newPapers
    const AboutScreen() // Pagina del creador
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Gender Prediction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Age',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'university',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'news',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Creador',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        onTap: _onItemTapped,
      ),
    );
  }
}

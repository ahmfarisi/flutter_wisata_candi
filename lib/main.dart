import 'package:flutter/material.dart';
import 'package:flutter_wisata_candi/data/candi_data.dart';
import 'package:flutter_wisata_candi/models/candi.dart';
import 'package:flutter_wisata_candi/screens/detail_screen.dart';
import 'package:flutter_wisata_candi/screens/home_screen.dart';
import 'package:flutter_wisata_candi/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown)),
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final candi = settings.arguments as Candi;
          return MaterialPageRoute(
              builder: (context) => DetailScreen(candi: candi));
        }
        return null;
      },
    );
  }
}

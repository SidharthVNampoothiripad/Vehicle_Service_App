import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'home_screen.dart';
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CarServiceApp());
}


class CarServiceApp extends StatelessWidget {
  // Simulate some initialization process
  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay of 2 seconds
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Initialization is complete, return your app's main screen
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Car Service App',
            theme: ThemeData(
              primarySwatch: Colors.yellow,
              colorScheme: ColorScheme.fromSwatch(
                accentColor: Colors.amber,
              ), // Accent color directly under ThemeData
              fontFamily: 'Montserrat', // Your selected font
            ),
            home: LoginPage(),
          );
        } else {
          // Show a loading indicator while waiting for initialization to complete
          return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Scaffold(
    body: Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        "assets/loading_page.png",
      ),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
);

        }
      },
    );
  }
}

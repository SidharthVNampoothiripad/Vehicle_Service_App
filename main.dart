import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(CarServiceApp());

class CarServiceApp extends StatelessWidget {
  // Simulate some initialization process
  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 5)); // Simulating a delay of 2 seconds
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
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSwatch(
                accentColor: Colors.amber,
              ), // Accent color directly under ThemeData
              fontFamily: 'Montserrat', // Your selected font
            ),
            home: CarServiceHomePage(),
          );
        } else {
          // Show a loading indicator while waiting for initialization to complete
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(CarServiceApp());

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
  debugShowCheckedModeBanner: false,
  home: Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1595521488367-9b130f86bbe3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGNhciUyMGltYWdlJTIwcG90cmFpdHxlbnwwfDF8MHx8fDA%3D', // Replace with your actual image URL
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

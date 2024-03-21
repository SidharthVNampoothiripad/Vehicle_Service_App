import 'package:flutter/material.dart';
//import 'home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
       apiKey: "AIzaSyB0stCkFLyNFJI20FmE0zaFzTP2KBPEY70",
        appId: "1:354057994820:android:931f4b3af4c6011154b211",
        messagingSenderId: "354057994820",
        projectId: "fixflow-e3983",
        storageBucket: "fixflow-e3983.appspot.com"),
  );

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

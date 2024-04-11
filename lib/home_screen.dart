import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'location_calc/loc_eqn.dart'; // Import LocationCalculation class

// Import other necessary files
import 'service_center_card.dart';
import 'search_page.dart';
import 'carousel.dart';
import 'user_details.dart';

class CarServiceHomePage extends StatefulWidget {
  @override
  State<CarServiceHomePage> createState() => _CarServiceHomePageState();
}

class _CarServiceHomePageState extends State<CarServiceHomePage> {
  late Future<List<DocumentSnapshot>> _serviceCentres;
  List<String> imagePaths = [
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
  ];
  int imageIndex = 0;

  double? userLat;
  double? userLong;

  @override
  void initState() {
    super.initState();
    _getLocationAndStore(); // Call the method to get location and store it
    _serviceCentres = _fetchSortedServiceCenters();
  }

  // Method to get the user's location and store it in Firestore
  _getLocationAndStore() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
  
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        // Permissions granted, proceed to get the location
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          userLat = position.latitude;
          userLong = position.longitude;
        });
        
        // Get the current user's email
        String? email = FirebaseAuth.instance.currentUser?.email;
        if (email != null) {
          // Store latitude and longitude in Firestore under Users collection with the document ID as the email
          await FirebaseFirestore.instance.collection('Users').doc(email).update({
              'latitude': userLat,
              'longitude': userLong,
          });
        } else {
          print('Error getting user email: User is not logged in');
        }
      } else {
        // Permissions not granted, handle accordingly (show a message, ask again, etc.)
        print('Location permission denied.');
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  // Method to fetch service centers sorted by distance
  Future<List<DocumentSnapshot>> _fetchSortedServiceCenters() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Service_Centres').get();

      // Calculate distances and sort by them
      List<DocumentSnapshot> serviceCentres = snapshot.docs;
      serviceCentres.sort((a, b) {
        double distanceToA = LocationCalculator.calculateDistance(
          userLat!,
          userLong!,
          a['locValue']['latitude'],
          a['locValue']['longitude'],
        );
        double distanceToB = LocationCalculator.calculateDistance(
          userLat!,
          userLong!,
          b['locValue']['latitude'],
          b['locValue']['longitude'],
        );
        return distanceToA.compareTo(distanceToB);
      });

      return serviceCentres;
    } catch (e) {
      print('Error fetching and sorting service centers: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fix Flow',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 250, 223, 255),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 60, // Adjust the height of the DrawerHeader
              child: DrawerHeader(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 116, 47, 129),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FixFlow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('My Orders'),
              onTap: () {
                // Add navigation logic here
              },
            ),
            ListTile(
              title: Text('Favourites'),
              onTap: () {
                // Add navigation logic here
              },
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 207, 173, 210),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _serviceCentres,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<DocumentSnapshot> serviceCentres = snapshot.data!;

            return ListView(
              children: <Widget>[
                CustomCarousel(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Service Centers Near You',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                // Display sorted service centers
                for (var serviceCenter in serviceCentres)
                  ServiceCenterCard(
                    name: serviceCenter['Service Center Name'],
                    location: serviceCenter['Location'],
                    phoneNumber: serviceCenter['Phone Number'],
                    imagePath: imagePaths[
                        imageIndex++ % imagePaths.length], // Get the image path based on the current index
                    services: List<String>.from(
                        serviceCenter['Services_offered']),
                    distance: LocationCalculator.calculateDistance(
                      userLat!,
                      userLong!,
                      serviceCenter['locValue']['latitude'],
                      serviceCenter['locValue']['longitude'],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellogram/home_screen.dart';

class ServiceCenterDetailsPage extends StatefulWidget {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final List<String> services;

  ServiceCenterDetailsPage({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.services,
  });

  @override
  _ServiceCenterDetailsPageState createState() => _ServiceCenterDetailsPageState();
}

class _ServiceCenterDetailsPageState extends State<ServiceCenterDetailsPage> {
  List<bool> selectedServices = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list of selected services with false values
    selectedServices = List.generate(widget.services.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 237, 214, 247), // Grey background color
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey), // Optional border for styling
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200.0, // Increased height of the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12.0), // Adjusted spacing
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating: ${widget.rating}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Services offered:',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.services.length, (index) {
                        return CheckboxListTile(
                          title: Text(widget.services[index]),
                          value: selectedServices[index],
                          onChanged: (value) {
                            setState(() {
                              selectedServices[index] = value!;
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        backgroundColor: Colors.purple, // Violet color
                        foregroundColor: Colors.white, // White text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Rounded edges
                        ),
                      ),
                     onPressed: () async {
  // Get current user's email
  User? user = FirebaseAuth.instance.currentUser;
  String? userEmail = user?.email;

  // Check if at least one service is selected
  if (selectedServices.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('At least one service should be selected')),
    );
  } else if (userEmail != null) {
    List<String> selectedServiceNames = [];
    for (int i = 0; i < selectedServices.length; i++) {
      if (selectedServices[i]) {
        selectedServiceNames.add(widget.services[i]);
      }
    }

    try {
      // Fetch user information from 'Users' collection
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance.collection('Users').doc(userEmail).get();
      if (userDataSnapshot.exists) {
        Map<String, dynamic> userData = userDataSnapshot.data() as Map<String, dynamic>;

        // Store selected services along with user data
        await FirebaseFirestore.instance.collection('Services Requested').doc(userEmail).set({
          'Name': userData['Name'],
          'Phone Number': userData['Phone Number'],
          'Location': userData['location'],
          'Selected Services': selectedServiceNames,
        });

        // Handle successful order, e.g., navigate to home page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ordered successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CarServiceHomePage()),
        );
      } else {
        // User data not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data not found')),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }
},
                      child: Text('Order', style: TextStyle(fontSize: 14.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> whereIndexed(bool Function(int index, T element) test) sync* {
    var index = 0;
    for (final element in this) {
      if (test(index, element)) {
        yield element;
      }
      index++;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellogram/upi_payment.dart';

class ServiceCenterDetailsPage extends StatefulWidget {
  final String name;
  final String location;
  final String imagePath;
  final String phoneNumber;
  final double distance;
  final List<String> services;
  final Map<String, int> serviceAmounts;
  final String email;

  ServiceCenterDetailsPage({
    required this.name,
    required this.location,
    required this.imagePath,
    required this.phoneNumber,
    required this.distance,
    required this.services,
    required this.serviceAmounts,
    required this.email
  });

  @override
  _ServiceCenterDetailsPageState createState() =>
      _ServiceCenterDetailsPageState();
}

class _ServiceCenterDetailsPageState extends State<ServiceCenterDetailsPage> {
  List<bool> selectedServices = [];

  @override
  void initState() {
    super.initState();
    selectedServices =
        List.generate(widget.services.length, (index) => false);
  }

void placeOrder(String userEmail, String serviceCenterName, List<String> selectedServices, int totalAmount) async {
  try {
    // Get current user's details from Firestore Users collection
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(userEmail).get();
    if (userSnapshot.exists) {
      // Retrieve user details
      String userName = userSnapshot.get('Name');
      String userLocation = userSnapshot.get('Location');
      String userPhoneNumber = userSnapshot.get('Phone Number');

      // Get a reference to the service center's document
      DocumentReference serviceCenterRef = FirebaseFirestore.instance.collection('Orders_placed').doc(widget.email);

      // Add a subcollection with the user's email as its ID
      CollectionReference ordersCollection = serviceCenterRef.collection('orders');
      await ordersCollection.doc(userEmail).set({
        'userEmail': userEmail,
        'userName': userName,
        'userLocation': userLocation,
        'userPhoneNumber': userPhoneNumber,
        'serviceCenterName': serviceCenterName,
        'selectedServices': selectedServices,
        'totalAmount': totalAmount,
        'createdAt': FieldValue.serverTimestamp(), // Optional, adds a timestamp
      });
      print('Order placed successfully');
    } else {
      print('User details not found');
    }
  } catch (e) {
    print('Error placing order: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;
    for (int i = 0; i < widget.services.length; i++) {
      if (selectedServices[i]) {
        totalAmount += widget.serviceAmounts[widget.services[i]] ?? 0;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    child: Image.asset(
                      widget.imagePath,
                      width: double.infinity,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text(
                              '\u{1F4CD} ${widget.location} | \u{1F4DE} ${widget.phoneNumber} | ${widget.distance.toStringAsFixed(2)} km',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Services offered:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(widget.services.length, (index) {
                          return CheckboxListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.services[index]),
                                if (selectedServices[index])
                                  Text(
                                    'Amount: ${widget.serviceAmounts[widget.services[index]]}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            totalAmount.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Assuming you have the user's email stored in a variable called 'userEmail'
                          String? userEmail = FirebaseAuth.instance.currentUser?.email;
                          if (userEmail != null) {
                            placeOrder(userEmail, widget.name, widget.services, totalAmount);
                          }
                          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpiPaymentPage()),
                );
                        },
                        child: Text('Order'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

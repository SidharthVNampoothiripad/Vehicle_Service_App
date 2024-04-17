  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';

  class MyOrdersPage1 extends StatelessWidget {
     final String userEmail;

  MyOrdersPage1({required this.userEmail});
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          backgroundColor: Color.fromARGB(255, 182, 200, 247),
        ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
  stream: FirebaseFirestore.instance
    .collection('Orders_pending')
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection('orders')
    .doc(userEmail)
    .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      print('Error retrieving order: ${snapshot.error}');
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    var orderData = snapshot.data!.data();
    if (orderData == null) {
      return Center(child: Text('Order not acknowledged by service center'));
    }

    // Access the order details
    String date = orderData['date']?? 'N/A';
    String time = orderData['time']?? 'N/A';
    String workerName = orderData['workerName']?? 'N/A';
    String message = orderData['message']?? 'N/A';

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expected Date: $date',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Expected Time: $time',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Worker Name: $workerName',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Message: $message',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Service Centre Email: $userEmail',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          );
        },
);
          },
        ),
      );
    }
  }

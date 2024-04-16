  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';

  class MyOrdersPage1 extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          backgroundColor: Color.fromARGB(255, 182, 200, 247),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Orders_pending')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('orders')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

   if (snapshot.hasError) {
        print('Error retrieving orders: ${snapshot.error}');
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      final orders = snapshot.data!.docs;
      

      if (orders.isEmpty) {
        return Center(
          child: Text(
            'You have no orders',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        );
      }

      return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final orderData = orders[index].data() as Map<String, dynamic>;

          // Accessing order details
          String userEmail = orders[index].id; // Using document ID as user email
          String date = orderData['date'];
          String time = orderData['time'];
          String workerName = orderData['workerName'];
          String message = orderData['message'];

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
            onTap: () {
              // Handle onTap event if needed
            },
          );
        },
);
          },
        ),
      );
    }
  }

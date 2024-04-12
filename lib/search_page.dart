// search_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_center_card.dart';
import 'service_center_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search Service Centers',
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: getServiceCenters(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No service centers found.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot serviceCenter = snapshot.data![index];
                      return ServiceCenterCard(
                        name: serviceCenter['name'],
                        phoneNumber: serviceCenter['phoneNumber'],
                        location: serviceCenter['location'],
                        services: List<String>.from(serviceCenter['services']),
                        imagePath: serviceCenter['imagePath'],
                        distance: serviceCenter['distance'] != null ? serviceCenter['distance'].toDouble() : null,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<DocumentSnapshot>> getServiceCenters(String? searchQuery) async {
    // Query Firestore based on the search query
    // Example query: Fetch service centers where the name contains the search query
    // Modify this query based on your Firestore structure and requirements
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('serviceCenters')
        .where('name', isEqualTo: searchQuery)
        .get();

    return querySnapshot.docs;
  }
}

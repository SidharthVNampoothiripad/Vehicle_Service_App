import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_center_card.dart';
import 'service_center_detail_page.dart';

enum SortBy { Name, Distance }

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
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
  SortBy _sortBy = SortBy.Name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Service Centers'),
       backgroundColor: Color.fromARGB(255, 250, 223, 255),
        actions: [
          PopupMenuButton<SortBy>(
            onSelected: (SortBy result) {
              setState(() {
                _sortBy = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortBy>>[
              const PopupMenuItem<SortBy>(
                value: SortBy.Name,
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem<SortBy>(
                value: SortBy.Distance,
                child: Text('Sort by Distance'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Service Centers',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Service_Centres').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

               final serviceCenters = snapshot.data!.docs.where((doc) {
  final name = doc['Service Center Name'].toString().toLowerCase();
  final List<dynamic> services = doc['Services_offered'] ?? [];

  return name.contains(_searchQuery) ||
      services.any((service) => service.toString().toLowerCase().contains(_searchQuery));
});

                if (serviceCenters.isEmpty) {
                  return Center(child: Text('No service centers found.'));
                }

                var sortedServiceCenters = serviceCenters.toList();

                if (_sortBy == SortBy.Distance) {
                  sortedServiceCenters.sort((a, b) {
                    final distanceA = a['distance'] ?? double.infinity;
                    final distanceB = b['distance'] ?? double.infinity;
                    return distanceA.compareTo(distanceB);
                  });
                }

                return ListView.builder(
                  itemCount: sortedServiceCenters.length,
                  itemBuilder: (context, index) {
                    final serviceCenter = sortedServiceCenters[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceCenterDetailsPage(
                              name: serviceCenter['Service Center Name'],
                              location: serviceCenter['Location'],
                              imagePath: imagePaths[imageIndex++ % imagePaths.length],
                              phoneNumber: serviceCenter['Phone Number'],
                              distance: serviceCenter['Distance'],
                              services: serviceCenter['Services'],
                              serviceAmounts: serviceCenter['Service Amounts'],
                              email: serviceCenter['Email'],
                            ),
                          ),
                        );
                      },
                      child: ServiceCenterCard(
                        name: serviceCenter['Service Center Name'],
                        phoneNumber: serviceCenter['Phone Number'],
                        location: serviceCenter['Location'],
                        services: List<String>.from(serviceCenter['Services_offered']),
                        imagePath: imagePaths[imageIndex++ % imagePaths.length],
                        distance: serviceCenter['distance'] != null ? serviceCenter['distance'].toDouble() : 0.0,
                        serviceAmounts: Map<String, int>.from(serviceCenter['Service_Amounts']),
                        email: serviceCenter['Email'],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

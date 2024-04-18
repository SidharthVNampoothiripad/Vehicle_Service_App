import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_center_card.dart';

class CarouselDetailed extends StatelessWidget {
  final String selectedService;

  CarouselDetailed({required this.selectedService});
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 223, 255),
        title: Text(selectedService),
      ),
      
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Service_Centres')
            .where('Services_offered', arrayContains: selectedService)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final serviceCenters = snapshot.data!.docs;

          return ListView.builder(
            itemCount: serviceCenters.length,
            itemBuilder: (context, index) {
              final centerData = serviceCenters[index].data() as Map<String, dynamic>;
              return ServiceCenterCard(
                name: centerData['Service Center Name'],
                phoneNumber: centerData['Phone Number'],
                email:centerData['Email'],
                location: centerData['Location'],
                services: List<String>.from(centerData['Services_offered']),
               imagePath: imagePaths[
                        imageIndex++ % imagePaths.length], // Get the image path based on the current index
                distance: centerData['distance'] != null ? centerData['distance'].toDouble() : 0.0,
                serviceAmounts: Map<String, int>.from(centerData['Service_Amounts']),
                rating: (centerData['rate'] ?? 0.0).toDouble(),
              );
            },
          );
        },
      ),
    );
  }
}

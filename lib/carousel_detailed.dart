import 'package:flutter/material.dart';
import 'package:hellogram/service_center_detail_page.dart';
import 'service_centre_link_card.dart'; // Import the new file // Import the service center details page

class CarouselDetailed extends StatelessWidget {
  final String selectedService;

  CarouselDetailed({required this.selectedService});

  // Manual data for service centers related to the selected service
  Map<String, List<String>> serviceCentersData = {
    'Car Wash': ['Service Center C', 'Service Center E'],
    'Engine': ['Service Center B', 'Service Center D'], // Added 'Service Center F' for Engine Tune-up
    'Tyre ': ['Service Center A'], // Added 'Service Center G' for Tyre Services
    'Chassis': ['Service Center D'],
  };

  @override
  Widget build(BuildContext context) {
    // Get the service centers for the selected service
    List<String>? serviceCenters = serviceCentersData[selectedService];

    return Scaffold(
      appBar: AppBar(
        title: Text('Service Centers for $selectedService'),
      ),
      body: serviceCenters != null && serviceCenters.isNotEmpty
          ? ListView.builder(
              itemCount: serviceCenters.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the ServiceCenterDetailsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceCenterDetailsPage(
                          name: serviceCenters[index],
                          location: '', // Pass location if needed
                          imageUrl: '', // Pass image URL if needed
                          rating: 0.0, // Pass rating if needed
                          services: [], // Pass services if needed
                        ),
                      ),
                    );
                  },
                  child: ServiceCenterLinkCard(serviceCenterName: serviceCenters[index]),
                );
              },
            )
          : Center(
              child: Text('No service centers found for $selectedService'),
            ),
    );
  }
}

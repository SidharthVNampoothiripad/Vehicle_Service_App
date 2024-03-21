// carousel_detailed.dart
import 'package:flutter/material.dart';
import 'service_centre_link_card.dart'; // Import the new file

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
                return ServiceCenterLinkCard(serviceCenterName: serviceCenters[index]);
              },
            )
          : Center(
              child: Text('No service centers found for $selectedService'),
            ),
    );
  }
}

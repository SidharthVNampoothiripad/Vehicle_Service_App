// carousel_detailed.dart
import 'package:flutter/material.dart';

class CarouselDetailed extends StatelessWidget {
  final String selectedService;

  CarouselDetailed({required this.selectedService});

  @override
  Widget build(BuildContext context) {
    // Dummy data for service centers related to the selected service
    List<String> serviceCenters = [
      'Service Center 1',
      'Service Center 2',
      'Service Center 3',
      // Add more service centers as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Service Centers for $selectedService'),
      ),
      body: ListView.builder(
        itemCount: serviceCenters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(serviceCenters[index]),
            // You can customize the ListTile based on your needs
            // For example, you might want to add more details about each service center
          );
        },
      ),
    );
  }
}

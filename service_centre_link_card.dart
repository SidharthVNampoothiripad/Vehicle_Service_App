// service_center_link_card.dart
import 'package:flutter/material.dart';
import 'carousel_detailed.dart'; // Import the necessary file

class ServiceCenterLinkCard extends StatelessWidget {
  final String serviceCenterName;

  ServiceCenterLinkCard({required this.serviceCenterName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detailed page when the card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarouselDetailed(selectedService: serviceCenterName),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            serviceCenterName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

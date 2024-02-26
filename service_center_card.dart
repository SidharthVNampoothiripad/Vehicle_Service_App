import 'package:flutter/material.dart';
import 'service_center_detail_page.dart';

class ServiceCenterCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final List<String> services;

  ServiceCenterCard({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceCenterDetailsPage(
              name: name,
              imageUrl: imageUrl,
              rating: rating,
              services: services,
            ),
          ),
        );
      },
      child: Card(
   // Set the background color of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Container(
                width: double.infinity,
                height: 120.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Rating: $rating'),
                      Text('Services: ${services.join(", ")}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// service_center_card.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_center_detail_page.dart';

class ServiceCenterCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String location;
  final List<String> services;
  final String imagePath;
  final double? distance;

  ServiceCenterCard({
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.services,
    required this.imagePath,
    this.distance,
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
              location: location,
              services: services,
              phoneNumber: phoneNumber,
              imagePath: imagePath,
              distance: distance ?? 0,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    services.join(', '),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (distance != null)
                        Text(
                          '${distance?.toStringAsFixed(2)} km',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        Text(
                          'Calculating distance...',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

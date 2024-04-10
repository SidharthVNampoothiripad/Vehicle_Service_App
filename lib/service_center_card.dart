import 'package:flutter/material.dart';
import 'service_center_detail_page.dart';

class ServiceCenterCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String location;
  final List<String> services;
  final String imagePath;
  //final double distance;
  ServiceCenterCard({
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.services,
    required this.imagePath,
    //required this.distance, // Initialize distance parameter
  });

  get rating => 0;

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
               //distance: distance, // Pass distance to the details page
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
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    services.join(', '), // Display services as a comma-separated string
                    style: TextStyle(fontSize: 14.0),
                  ),
                  /*Text(
              'Distance: ${distance.toStringAsFixed(2)} km', // Display distance
              style: TextStyle(fontSize: 10.0),
            ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

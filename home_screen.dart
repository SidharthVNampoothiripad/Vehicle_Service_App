// car_service_home_page.dart
import 'package:flutter/material.dart';
import 'service_center_card.dart';
import 'authentication_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'search_page.dart'; // Import the newly created SearchPage

class CarServiceHomePage extends StatefulWidget {
  @override
  State<CarServiceHomePage> createState() => _CarServiceHomePageState();
}

class _CarServiceHomePageState extends State<CarServiceHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fix Flow',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()), // Navigate to the SearchPage
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthenticationPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
         // Carousel Slider
Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Services',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  ),
),
CarouselSlider(
  items: [
    // Add your carousel items here
    ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        'https://plus.unsplash.com/premium_photo-1661384383060-247be4fec056?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2FyJTIwY2xlYW5pbmd8ZW58MHx8MHx8fDA%3D',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        'https://plus.unsplash.com/premium_photo-1682141708282-3a4f7023e1bb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwYmF0dGVyeXxlbnwwfHwwfHx8MA%3D%3D',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        'https://images.unsplash.com/photo-1526459915562-c5ca724b1d02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2FyJTIwd2luZHNoaWVsZHxlbnwwfHwwfHx8MA%3D%3D',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        'https://images.unsplash.com/photo-1592318348310-f31b61a931c8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwYmF0dGVyeXxlbnwwfHwwfHx8MA%3D%3D',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
  ],
  options: CarouselOptions(
    height: 100.0,
    enlargeCenterPage: true,
    enableInfiniteScroll: true,
  ),
),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Service Centers Near You',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          ServiceCenterCard(
            name: 'Service Center A',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1677009541899-28700f6c20a8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8fDA%3D',
            rating: 4.5,
            services: ['Oil Change', 'Tire Rotation'],
          ),
          ServiceCenterCard(
            name: 'Service Center B',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1676998430827-aee8e597b013?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNhciUyMHdvcmtzaG9wfGVufDB8fDB8fHww',
            rating: 4.2,
            services: ['Brake Inspection', 'Engine Tune-up'],
          ),
          ServiceCenterCard(
            name: 'Service Center C',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1663045610933-af6f1ca26c6e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fGNhciUyMHdvcmtzaG9wfGVufDB8fDB8fHww',
            rating: 4.2,
            services: ['Brake Inspection', 'Engine Tune-up'],
          ),
          ServiceCenterCard(
            name: 'Service Center D',
            imageUrl: 'https://images.unsplash.com/photo-1615906655593-ad0386982a0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8fDA%3D',
            rating: 4.2,
            services: ['Brake Inspection', 'Engine Tune-up'],
          ),
          ServiceCenterCard(
            name: 'Service Center E',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1675810094948-d4634e766d2b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2FyJTIwc2VydmljZXxlbnwwfHwwfHx8MA%3D%3D',
            rating: 4.2,
            services: ['Brake Inspection', 'Engine Tune-up'],
          ),
          // Add more ServiceCenterCard widgets for other service centers
        ],
      ),
    );
  }
}

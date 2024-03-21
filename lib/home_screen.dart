// car_service_home_page.dart
import 'package:flutter/material.dart';
import 'service_center_card.dart';
import 'search_page.dart'; 
import 'carousel.dart';
import 'user_details.dart';

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
        backgroundColor: Color.fromARGB(255, 250, 223, 255),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInfo()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 207, 173, 210),
        child: ListView(
        children: <Widget>[
          CustomCarousel(),
          
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Service Centers Near You',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          ServiceCenterCard(
            name: 'Service Center A',
            location: 'Chengannur',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1677009541899-28700f6c20a8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8fDA%3D',
            rating: 4.5,
            services: ['Wheel alignment', 'Tire Rotation','Nitrogen filling'],
          ),
          ServiceCenterCard(
            name: 'Service Center B',
            location: 'Thiruvalla',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1676998430827-aee8e597b013?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNhciUyMHdvcmtzaG9wfGVufDB8fDB8fHww',
            rating: 4.2,
            services: ['Oil change', 'Engine Tune-up','Gear box and Clutch maintenance'],
          ),
          ServiceCenterCard(
            name: 'Service Center C',
            location: 'Changanassery',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1663045610933-af6f1ca26c6e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fGNhciUyMHdvcmtzaG9wfGVufDB8fDB8fHww',
            rating: 4.2,
            services: ['Dent and scratch repair', 'Washing','Graphite coating'],
          ),
          ServiceCenterCard(
            name: 'Service Center D',
            location: 'Pandalam',
            imageUrl: 'https://images.unsplash.com/photo-1615906655593-ad0386982a0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8fDA%3D',
            rating: 4.0,
            services: ['Brake Inspection', 'Engine Tune-Up','Chassis'],
          ),
          ServiceCenterCard(
            name: 'Service Center E',
            location: 'Adoor',
            imageUrl: 'https://plus.unsplash.com/premium_photo-1675810094948-d4634e766d2b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2FyJTIwc2VydmljZXxlbnwwfHwwfHx8MA%3D%3D',
            rating: 3.9,
            services: ['Car detailing','Glasses','Washing'],
          ),
          // Add more ServiceCenterCard widgets for other service centers
        ],
      ),
      )
    );
  }
}

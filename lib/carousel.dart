// carousel.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'carousel_detailed.dart';

class CustomCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Services',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          items: [
            CarouselItem(
              imageUrl:
                  'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd2FzaHxlbnwwfDB8MHx8fDA%3D',
              selectedService: 'Washing',
            ),
            CarouselItem(
              imageUrl:
                  'https://plus.unsplash.com/premium_photo-1661717357358-67ae75ca57cd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwZW5naW5lfGVufDB8MHwwfHx8MA%3D%3D',
              selectedService: 'Engine',
            ),
            CarouselItem(
              imageUrl:
                  'https://plus.unsplash.com/premium_photo-1663040170005-2c302347d703?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwdHlyZSUyMHNlcnZpY2V8ZW58MHwwfDB8fHww',
              selectedService: 'Tyre',
            ),
            CarouselItem(
              imageUrl:
                  'https://images.unsplash.com/photo-1697136646544-c9bd04d8bf98?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2FyJTIwY2hhc3Npc3xlbnwwfDB8MHx8fDA%3D',
              selectedService: 'Chassis',
            ),
          ],
          options: CarouselOptions(
            height: 100.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
          ),
        ),
      ],
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final String selectedService;

  CarouselItem({required this.imageUrl, required this.selectedService});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next page when carousel item is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarouselDetailed(selectedService: selectedService),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  selectedService,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

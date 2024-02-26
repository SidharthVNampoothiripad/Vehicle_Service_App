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
                  'https://plus.unsplash.com/premium_photo-1661384383060-247be4fec056?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2FyJTIwY2xlYW5pbmd8ZW58MHx8MHx8fDA%3D',
              selectedService: 'Oil Change',
            ),
            CarouselItem(
              imageUrl:
                  'https://plus.unsplash.com/premium_photo-1682141708282-3a4f7023e1bb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwYmF0dGVyeXxlbnwwfHwwfHx8MA%3D%3D',
              selectedService: 'Brake Inspection',
            ),
            CarouselItem(
              imageUrl:
                  'https://images.unsplash.com/photo-1526459915562-c5ca724b1d02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2FyJTIwd2luZHNoaWVsZHxlbnwwfHwwfHx8MA%3D%3D',
              selectedService: 'Engine Tune-up',
            ),
            CarouselItem(
              imageUrl:
                  'https://images.unsplash.com/photo-1592318348310-f31b61a931c8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwYmF0dGVyeXxlbnwwfHwwfHx8MA%3D%3D',
              selectedService: 'Other Service',
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
        child: Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ServiceCenterDetailsPage extends StatefulWidget {
  final String name;
  final String location;
  final String imagePath;
  final String phoneNumber;
  final double distance;
  final List<String> services;

  ServiceCenterDetailsPage({
    required this.name,
    required this.location,
    required this.imagePath,
    required this.phoneNumber,
    required this.distance,
    required this.services,
  });

  @override
  _ServiceCenterDetailsPageState createState() =>
      _ServiceCenterDetailsPageState();
}

class _ServiceCenterDetailsPageState extends State<ServiceCenterDetailsPage> {
  List<bool> selectedServices = [];

  @override
  void initState() {
    super.initState();
    selectedServices =
        List.generate(widget.services.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    child: Image.asset(
                      widget.imagePath,
                      width: double.infinity,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text(
                                '\u{1F4CD} ${widget.location} | \u{1F4DE} ${widget.phoneNumber} | ${widget.distance.toStringAsFixed(2)} km',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Services offered:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(widget.services.length, (index) {
                          return CheckboxListTile(
                            title: Text(widget.services[index]),
                            value: selectedServices[index],
                            onChanged: (value) {
                              setState(() {
                                selectedServices[index] = value!;
                              });
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add logic for order button
                        },
                        child: Text('Order'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
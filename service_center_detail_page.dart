import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellogram/home_screen.dart';

class ServiceCenterDetailsPage extends StatefulWidget {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final List<String> services;

  ServiceCenterDetailsPage({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.services,
  });

  @override
  _ServiceCenterDetailsPageState createState() => _ServiceCenterDetailsPageState();
}

class _ServiceCenterDetailsPageState extends State<ServiceCenterDetailsPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> selectedServices = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list of selected services with false values
    selectedServices = List.generate(widget.services.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey), // Optional border for styling
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 400.0,
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
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12.0), // Adjusted spacing
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating: ${widget.rating}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Services offered:',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
  onPressed: () async {
    if (selectedServices.any((service) => service == true)) {
      try {
        // Construct a list of selected services along with the service center name
        List<Map<String, dynamic>> selectedServicesWithCenterName = selectedServices
          .asMap()
          .entries
          .where((entry) => entry.value)
          .map((entry) => {
            'service_center_name': widget.name, // Add the service center name
            'service_name': widget.services[entry.key], // Add the service name
          })
          .toList();

        // Save the selected services to Firestore
        await FirebaseFirestore.instance.collection('services_offered').add({
          'selected_services': selectedServicesWithCenterName,
        });
        
        // Navigate back to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CarServiceHomePage()),
        );
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('Please select at least one service');
    }
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
    );
  }
}
extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> whereIndexed(bool Function(int index, T element) test) sync* {
    var index = 0;
    for (final element in this) {
      if (test(index, element)) {
        yield element;
      }
      index++;
    }
  }
}

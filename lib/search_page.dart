// search_page.dart
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search for services and service centres',
          style: TextStyle(fontSize: 16.0), // Adjust the font size as needed
        ),
      ),
     body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0), // Increased borderRadius
              ),
              child: GestureDetector(
                onTap: () {
                  // Implement search functionality
                  print('Search pressed');
                },
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none, // Remove TextField border
                    contentPadding: EdgeInsets.all(16.0),
                    suffixIcon: Icon(Icons.arrow_forward), // Right arrow icon
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Removed ElevatedButton
          ],
        ),
      ),
    );
  }
}
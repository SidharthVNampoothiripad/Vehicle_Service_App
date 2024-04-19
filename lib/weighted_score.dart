import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightedScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weighted Score Calculation'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('Service_Centres').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<DocumentSnapshot<Map<String, dynamic>>> serviceCentres = snapshot.data!.docs;

          // Calculate weighted score for each service center
          serviceCentres.forEach((serviceCenterDoc) async {
            double distance = serviceCenterDoc['distance'] ?? 0.0;
            double rating = serviceCenterDoc['rate'] ?? 0.0;
            int numOfServices = (serviceCenterDoc['Services_offered'] as List).length;

            // Check if 'score' field exists, if not, initialize it to 0
            if (!serviceCenterDoc.data()!.containsKey('score')) {
              try {
                await serviceCenterDoc.reference.update({'score': 0});
              } catch (e) {
                print('Error initializing score for ${serviceCenterDoc.id}: $e');
              }
            }

            // Calculate weighted score
            double score = (1000 * distance) + (100 * rating) + (10 * numOfServices);

            // Update the service center document with the calculated score
            try {
              await serviceCenterDoc.reference.update({'score': score});
            } catch (e) {
              print('Error updating score for ${serviceCenterDoc.id}: $e');
            }
          });

          return Container(
            child: Text('Weighted Scores Calculated'),
          );
        },
      ),
    );
  }
}

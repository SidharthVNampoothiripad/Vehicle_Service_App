import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class LocationCalculation {
  Future<void> calculateAndStoreDistance() async {
    try {

      String? email = FirebaseAuth.instance.currentUser?.email;


      if (email == null) {
        print('Error: User is not logged in. Distance calculation requires valid user location data.');
        return; 
      }

    
      DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(email);

      try {
        
        DocumentSnapshot userSnapshot = await userRef.get();

        
        if (userSnapshot.exists) {
          double userLatitude = userSnapshot['latitude'];
          double userLongitude = userSnapshot['longitude'];

          
          CollectionReference serviceCentersCollection = FirebaseFirestore.instance.collection('Service_Centres');

          
          QuerySnapshot serviceCentersSnapshot = await serviceCentersCollection.get();

          
          await Future.forEach(serviceCentersSnapshot.docs, (DocumentSnapshot doc) async {
            try {
              // Get service center's latitude and longitude
              double centerLat = doc['locValue']['latitude'];
              double centerLong = doc['locValue']['longitude'];

              double distanceInMeters = Geolocator.distanceBetween(userLatitude, userLongitude, centerLat, centerLong);

              
              double distanceInKilometers = distanceInMeters / 1000;

              // Format the distance to have two decimal places
              String formattedDistance = distanceInKilometers.toStringAsFixed(2);

              // Update the existing document with the formatted distance
              await doc.reference.update({'distance': double.parse(formattedDistance)});
            } catch (e) {
              print('Error updating distance for ${doc.id}: $e');
            }
          });

          print('Distances calculated and updated successfully.');
        } else {
          print('User document not found or no location data available');
        }
      } catch (e) {
        print('Error retrieving user location data: $e');
      }
    } catch (e) {
      print('Error fetching service centers: $e');
    }
  }

  Future<void> calculateAndStoreScores() async {
    try {
      // Fetch service centers from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Service_Centres').get();

      // Iterate through each service center document
      querySnapshot.docs.forEach((serviceCenterDoc) async {
        double distance = serviceCenterDoc['distance'] ?? 0.0;
        double rating = serviceCenterDoc['rate'] ?? 0.0;
        int numOfServices = (serviceCenterDoc['Services_offered'] as List).length;

        // Calculate weighted score
        double score = (10 * rating) + numOfServices - distance;

        // Update the service center document with the calculated score
        try {
          await serviceCenterDoc.reference.update({'score': score});
        } catch (e) {
          print('Error updating score for ${serviceCenterDoc.id}: $e');
        }
      });

      print('Scores calculated and updated successfully.');
    } catch (e) {
      print('Error calculating and updating scores: $e');
    }
  }
}

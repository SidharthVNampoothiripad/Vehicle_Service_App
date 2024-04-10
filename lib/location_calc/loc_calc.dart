import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationCalculation {
  Future<void> calculateAndSortServiceCenters(double userLat, double userLong) async {
    try {
      // Get a reference to the Firestore collection 'Service_Centres'
      CollectionReference serviceCentersCollection = FirebaseFirestore.instance.collection('Service_Centres');

      // Retrieve the documents from the 'Service_Centres' collection
      QuerySnapshot serviceCentersSnapshot = await serviceCentersCollection.get();

      // Iterate over each document in the 'Service_Centres' collection
      await Future.forEach(serviceCentersSnapshot.docs, (DocumentSnapshot doc) async {
        try {
          // Get latitude and longitude of the service center from the document data
          double centerLat = doc['locValue']['latitude'];
          double centerLong = doc['locValue']['longitude'];

          // Calculate the distance between the user's location and the service center
          double distance = 10; // Just for testing, replace with actual calculation
          // double distance = LocationCalculator.calculateDistance(userLat, userLong, centerLat, centerLong);

          // Print the distance value
          print('Distance to ${doc.id}: $distance km');

          // Add the service center along with its calculated distance to the list
          Map<String, dynamic> data = {
            'distance': distance,
          };

          // Get the current user's email
          String? email = FirebaseAuth.instance.currentUser?.email;

          if (email != null) {
            // Store the distance in the 'distance' collection within the service center's document
            await doc.reference.collection('distance').doc(email).set(data);
          } else {
            print('Error getting user email: User is not logged in');
          }
        } catch (e) {
          print('Error processing document ${doc.id}: $e');
        }
      });

      // Sort the service centers based on their distance from the user's location
      // This can be done outside the forEach loop if you need to use the sorted list further
    } catch (e) {
      print('Error fetching service centers: $e');
    }
  }
}

import 'dart:math';
class LocationCalculator {
  static const earthRadius = 6371.0; // Radius of the Earth in kilometers

  // Function to calculate the distance between two sets of latitude and longitude coordinates
  static double calculateDistance(
      double userLat, double userLong, double centerLat, double centerLong) {
    // Convert latitude and longitude from degrees to radians
    double userLatRadians = _degreesToRadians(userLat);
    double userLongRadians = _degreesToRadians(userLong);
    double centerLatRadians = _degreesToRadians(centerLat);
    double centerLongRadians = _degreesToRadians(centerLong);

    // Calculate the change in coordinates
    double deltaLat = centerLatRadians - userLatRadians;
    double deltaLong = centerLongRadians - userLongRadians;

    // Apply Haversine formula
    double a = pow(sin(deltaLat / 2), 2) +
        cos(userLatRadians) *
            cos(centerLatRadians) *
            pow(sin(deltaLong / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  // Helper function to convert degrees to radians
  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }
}

enum Levels { low, medium, high }

class Alert {
  final String id;
  final DateTime timestamp;
  final String level;

  ///location
  final double latitude;
  final double longitude;

  ///location
  final bool isConfirmed;
  final String description;
  final String videoUrl; // Assuming URLs for video and images
  final List<String> imageUrls;
  Alert(this.id, this.timestamp, this.level, this.latitude, this.longitude,
      this.description, this.videoUrl, this.imageUrls, this.isConfirmed);
}

/*

class U {
  const U({required this.id, required this.name, required this.city});
  final String name;
  final String id;
  final String city;
  static U fromJson(json) => U(
        name: json['name'],
        id: json['id'],
        city: json['city'],
      );
}
 */

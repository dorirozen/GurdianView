// user_model.dart
class User {
  String id;
  String name;
  // Add other properties as needed

  User({required this.id, required this.name});

  User.empty() : this(id: '1', name: 'dori');
}

// camera_model.dart
class Camera {
  String id;
  String name;
  // Add other properties as needed

  Camera({required this.id, required this.name});
  Camera.empty() : this(id: '2', name: 'somewhere');
}

// setting_model.dart
class Setting {
  String id;
  String name;
  // Add other properties as needed

  Setting({required this.id, required this.name});
  Setting.empty() : this(id: '3', name: 'true');
}

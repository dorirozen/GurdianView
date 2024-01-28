import 'package:guardian_view/src/profile_try/entities.dart';

class Firetry {
  Future<List<User>> getUsers() async {
    List<User> c = [];
    c.add(User.empty());
    c.add(User.empty());
    c.add(User.empty());
    c.add(User.empty());
    return Future.value(c);
    // Fetch and return a list of users from Firestore
  }

  Future<List<Camera>> getCameras() async {
    List<Camera> c = [];
    c.add(Camera.empty());
    c.add(Camera.empty());
    c.add(Camera.empty());
    return Future.value(c);
    // Fetch and return a list of cameras from Firestore
  }

  Future<List<Setting>> getSettings() async {
    List<Setting> c = [];
    c.add(Setting.empty());
    c.add(Setting.empty());
    return Future.value(c);
    // Fetch and return a list of settings from Firestore
  }

  Future<void> addUser(User user) async {
    // Add a new user to Firestore
  }
  Future<void> addCamera(Camera camera) async {
    // Add a new user to Firestore
  }

  Future<void> editUser(User user) async {
    // Edit an existing user in Firestore
  }

  Future<void> deleteItem(String category, String itemId) async {}
// Add similar methods for cameras and settings
}

import 'package:equatable/equatable.dart';

// TODO: needs to add - currectLocation , active,
class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNum,
    required this.city,
    this.coworkers = const [],
  });
  final String uid;
  final String fullName;
  final String email;
  final String phoneNum;
  final String city;
  final List<String> coworkers;
  bool get isAdmin => email == 'd@g.com';
  LocalUser.empty()
      : this(
          uid: '',
          email: '',
          phoneNum: '',
          city: '',
          fullName: '',
          coworkers: const [],
        );

  @override
  List<Object?> get props => [
        uid,
        email,
        fullName,
        city,
        phoneNum,
        coworkers.length,
      ];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, fullName: $fullName, email: $email, phoneNum: $phoneNum, city: $city, coworkers: $coworkers}';
  }
}

import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/auth/domain/entites/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.phoneNum,
    required super.city,
    super.coworkers,
  });

  /// will help me when doing tests.
  const LocalUserModel.empty()
      : this(
          email: '',
          fullName: '',
          phoneNum: '',
          uid: '',
          city: '',
        );
  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          city: map['city'] as String,
          fullName: map['fullName'] as String,
    phoneNum: map['phoneNum'] as String,
          coworkers:
              (map['coworkers'] as List<dynamic>).cast<String>(),
        );

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'phoneNum': phoneNum,
      'city': city,
      'fullName': fullName,
      'coworkers': coworkers,
    };
  }

  LocalUserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNum,
    String? city,
    List<String>? coworkers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNum: phoneNum ?? this.phoneNum,
      city: city ?? this.city,
      coworkers: coworkers ?? this.coworkers,
    );
  }
}

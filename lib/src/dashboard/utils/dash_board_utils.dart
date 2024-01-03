import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/src/auth/data/models/user_model.dart';

class DashBoardUtils {
  const DashBoardUtils._();
  // each time something changes , we will get the new info!!
  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}

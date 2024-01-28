import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardian_view/core/error/exceptions.dart';
import 'package:guardian_view/src/alerts/data/models/alert_model.dart';

abstract class DataSourceAlert {
  const DataSourceAlert();
  Stream<List<AlertModel>> getAlerts();
}

class DataSourceAlertMyImpl implements DataSourceAlert {
  final FirebaseFirestore _firestore;

  const DataSourceAlertMyImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Stream<List<AlertModel>> getAlerts() {
    try {
      return _firestore
          .collection('alerts')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AlertModel.fromMap(
                    doc.data(),
                  ))
              .toList());
    } catch (e) {
      throw const ServerException(
          message: 'cannot achieve the list of alerts', statusCode: '500');
    }
  }
}

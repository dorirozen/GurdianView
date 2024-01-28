/*
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guardian_view/core/error/failures.dart';
import 'package:guardian_view/src/in_deployment/alerts/domain/entities/alert_entity.dart';
import 'package:guardian_view/src/in_deployment/alerts/domain/entities/video_entity.dart';
import 'package:guardian_view/src/in_deployment/alerts/domain/repo_alert/repo_alert.dart';
import 'package:guardian_view/src/in_deployment/alerts/domain/usercases/add_video_us.dart';
import 'package:mocktail/mocktail.dart';

class AlertRepoMock extends Mock implements AlertRepo {}

void main() {
  late AlertRepo alertRepo;
  late AddVideoDataUS addVideoDataUS;

  setUp(() async {
    alertRepo = AlertRepoMock();
    addVideoDataUS = AddVideoDataUS(alertRepo);
  });

  final video = VideoData.empty();
  group('testing addAlertUs ', () {
    test('should call the [ AlertRepoMock , AddAlertUs ] and return null',
        () async {
      ///arrange
      when(() => alertRepo.addVideoData(video))
          .thenAnswer((_) async => Right(Future.value(null)));

      ///act
      final call = addAlertUs;

      ///expect
      expect(call(alert), completes);
      verify(() => alertRepo.addAlert(alert)).called(1);
      verifyNoMoreInteractions(alertRepo);
    });

    test(
        'should call the [ AlertRepoMock , AddAlertUs ] and return ServerException',
        () async {
      ///arrange
      when(() => alertRepo.addAlert(alert)).thenAnswer((_) async =>
          Left(ServerFailure(message: 'didnt get it ', statusCode: 500)));

      ///act
      final call = await addAlertUs(alert);

      ///expect
      expect(
          call,
          equals(
              Left(ServerFailure(message: 'didnt get it ', statusCode: 500))));
      verify(() => alertRepo.addAlert(alert)).called(1);
      verifyNoMoreInteractions(alertRepo);
    });
  });
}

 */

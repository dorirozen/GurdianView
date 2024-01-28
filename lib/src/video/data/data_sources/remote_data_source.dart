import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guardian_view/core/error/exceptions.dart';
import 'package:guardian_view/src/video/data/models/video_model.dart';
import 'package:guardian_view/src/video/domain/entity/file_entity.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';

abstract class DataSourceVideo {
  const DataSourceVideo();
  Stream<TaskSnapshot> addVideoData(
      {required VideoFile videoFile, required VideoData videoData});
  Future<void> postUploadTask(
      {required VideoData videoData, required TaskSnapshot taskSnapshot});
}

class DataSourceVideoMyImpl implements DataSourceVideo {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  const DataSourceVideoMyImpl(
      {required FirebaseFirestore firestore,
      required FirebaseStorage firebaseStorage})
      : _firestore = firestore,
        _firebaseStorage = firebaseStorage;

  ///required FirebaseFirestore cloudStoreClient
  @override
  Stream<TaskSnapshot> addVideoData(
      {required VideoFile videoFile, required VideoData videoData}) {
    try {
      String fileName =
          'videos/${videoData.uid}/${videoData.timestamp.toString()}';
      Reference storageRef = _firebaseStorage.ref().child(fileName);
      UploadTask uploadTask = videoFile.isWebFile
          ? storageRef.putData(videoFile.bytes!)
          : storageRef.putFile(videoFile.file!);

      //await uploadTask.whenComplete(() => null);
      /*
      String videoUrl = await storageRef.getDownloadURL();

      // adding videoUrl for the null value
      VideoDataModel updatedVideoData = (videoData as VideoDataModel).copyWith(
        videoUrl: videoUrl,
        //timestamp: DateTime.now(), we want to save the moment the video was taken
      );

      // Upload video data to Firestore
      await _firestore.collection('videos').add(updatedVideoData.toMap());

      // return Future.value(null);
       */
      return uploadTask.snapshotEvents;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> postUploadTask(
      {required VideoData videoData,
      required TaskSnapshot taskSnapshot}) async {
    String videoUrl = await taskSnapshot.ref.getDownloadURL();
    // adding videoUrl for the null value
    VideoDataModel updatedVideoData = (videoData as VideoDataModel).copyWith(
      videoUrl: videoUrl,
      //timestamp: DateTime.now(), we want to save the moment the video was taken
    );
    // Upload video data to Firestore
    await _firestore.collection('videos').add(updatedVideoData.toMap());
  }
}

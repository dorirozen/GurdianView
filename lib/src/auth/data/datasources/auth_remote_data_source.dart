import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:guardian_view/core/enums/update_user.dart';
import 'package:guardian_view/core/error/exceptions.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(
      {required FirebaseAuth authClient,
      required FirebaseFirestore cloudStoreClient,
      required FirebaseStorage dbClient})
      : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;
  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<LocalUserModel> signIn(
      {required String email, required String password}) async {
    try {
      final userCredential = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw const ServerException(
          message: 'please try again later',
          statusCode: 'UnKnown Error',
        );
      }
      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }
      await _setUserData(user, email);
      userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'Error Occured', statusCode: e.code);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.updateDisplayName(fullName);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'Error Occured', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> updateUser(
      {required UpdateUserAction action, required userData}) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          await _authClient.currentUser?.updateEmail(userData as String); //auth
          await _updateUserData({'email': userData}); //firestore
          break;

        case UpdateUserAction.displayName:
          await _authClient.currentUser
              ?.updateDisplayName(userData as String); //auth
          await _updateUserData({'fullName': userData}); //firestore
          break;
        case UpdateUserAction
              .password: // we gonna get an old password , and a new password
          if (_authClient.currentUser!.email == null) {
            throw const ServerException(
                message: 'User does not exist',
                statusCode: 'Insufficient Permission');
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: _authClient.currentUser!.email!,
                password: newData['oldPassword'] as String),
          );
          await _authClient.currentUser
              ?.updatePassword(newData['newPassword'] as String);
          break;

        case UpdateUserAction.city:
          await _updateUserData({'city': userData as String});
          break;
        case UpdateUserAction.phoneNum:
          await _updateUserData({'phoneNum': userData as String});
          break;
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'Error Occured', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? '',
            city: '',
            phoneNum: '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    _cloudStoreClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}

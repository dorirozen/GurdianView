import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/dialog/entities/dialog_entities.dart';
import 'package:guardian_view/core/enums/dialog_enums/enums.dart';

class DialogService {
  late Function(DialogRequest) _showDialogListener;
  late Completer<DialogResponse> _dialogCompleter;
  Map<DialogType,
          Function(BuildContext, DialogRequest, Function(DialogResponse))>
      customDialogBuilders = {};
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  void registerCustomDialogBuilders(
      Map<DialogType,
              Function(BuildContext, DialogRequest, Function(DialogResponse))>
          builders) {
    customDialogBuilders.addAll(builders);
  }

  Future<DialogResponse> showDialog({
    required String title,
    required String description,
    required DialogType type,
    required BasicDialogStatus customData,
    required String mainButtonTitle,
    String? secondaryButtonTitle,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      statusData: customData,
      mainButtonTitle: mainButtonTitle,
      secondaryButtonTitle: secondaryButtonTitle,
      dialogType: type,
    ));
    return _dialogCompleter.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogCompleter.complete(response);
    //_dialogCompleter = null;
  }
}

import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/dialog/dialog_bridge_service.dart';
import 'package:guardian_view/core/enums/dialog_enums/enums.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';

class DialogMaker extends ChangeNotifier {
  DialogMaker({
    required this.title,
    required this.dialogType,
    required this.description,
    required this.mainButtonTitle,
    required this.statusData,
    this.secondaryButtonTitle,
  });
  final BasicDialogStatus statusData;
  final String title;
  final String description;
  final String mainButtonTitle;
  final String? secondaryButtonTitle;
  final DialogType dialogType;
  final DialogService _dialogService = sl<DialogService>();

  Future showDialog() async {
    debugPrint('dialog shown');
    var dialogResult = await _dialogService.showDialog(
        mainButtonTitle: mainButtonTitle,
        secondaryButtonTitle: secondaryButtonTitle,
        type: dialogType,
        customData: statusData,
        title: title,
        description: description);

    if (dialogResult.confirmed) {
      debugPrint('User has confirmed');
    } else {
      debugPrint('User cancelled the dialog');
    }
  }
}

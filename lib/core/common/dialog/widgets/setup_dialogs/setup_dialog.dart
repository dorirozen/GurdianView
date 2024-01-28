import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/dialog/dialog_bridge_service.dart';
import 'package:guardian_view/core/common/dialog/entities/dialog_entities.dart';
import 'package:guardian_view/core/common/dialog/widgets/basic_dialog/dialog_widget.dart';
import 'package:guardian_view/core/enums/dialog_enums/enums.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';

void setupDialogUi() {
  final dialogService = sl<DialogService>();

  ///register dialogs ui
  final builders = {
    DialogType.basic: (BuildContext context, DialogRequest req,
            Function(DialogResponse) completer) =>
        BasicDialog(
          request: req,
          completer: completer,
        )
  };
  dialogService.registerCustomDialogBuilders(builders);
}

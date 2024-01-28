import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/dialog/dialog_bridge_service.dart';
import 'package:guardian_view/core/common/dialog/entities/dialog_entities.dart';
import 'package:guardian_view/core/common/dialog/widgets/basic_dialog/dialog_widget.dart';
import 'package:guardian_view/core/common/dialog/widgets/setup_dialogs/setup_dialog.dart';
import 'package:guardian_view/core/enums/dialog_enums/enums.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  const DialogManager({super.key, required this.child});
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = sl<DialogService>();
  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
    setupDialogUi();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    if (_dialogService.customDialogBuilders.containsKey(request.dialogType)) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return _dialogService.customDialogBuilders[request.dialogType]!(
            context,
            request,
            (response) {
              _dialogService.dialogComplete(response);
              Navigator.of(context).pop();
            },
          );
        },
      );
    } else {
      // Fall back to the default Alert dialog if no custom builder is found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildDialog(request);
        },
      );
    }
  }

  Widget _buildDialog(DialogRequest request) {
    switch (request.dialogType) {
      case DialogType.basic:
        return BasicDialog(
          request: request,
          completer: (response) {
            _dialogService.dialogComplete(response);
            Navigator.of(context).pop();
          },
        );
      // Add more cases for different dialog types if needed
      default:
        return Container(); // Default empty container
    }
  }
}

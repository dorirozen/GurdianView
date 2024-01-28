import 'package:guardian_view/core/enums/dialog_enums/enums.dart';

class DialogRequest {
  final BasicDialogStatus statusData;
  final String title;
  final String description;
  final String mainButtonTitle;
  final String? secondaryButtonTitle;
  final DialogType dialogType;
  DialogRequest({
    required this.statusData,
    required this.title,
    required this.description,
    required this.mainButtonTitle,
    this.secondaryButtonTitle,
    required this.dialogType,
  });
}

class DialogResponse {
  final String? fieldOne;
  final String? fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    required this.confirmed,
  });
}

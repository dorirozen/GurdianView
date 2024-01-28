import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/dialog/factory_dialogs/dialog_maker.dart';
import 'package:guardian_view/core/enums/dialog_enums/enums.dart';
import 'package:provider/provider.dart';

class ExampleOfUsingDialog extends StatelessWidget {
  const ExampleOfUsingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: DialogMaker(
        dialogType: DialogType.basic,
        statusData: BasicDialogStatus.warning,
        title: 'Dialog Manager',
        description: 'Tryinggggggggggg to do ittt',
        mainButtonTitle: 'Dori Course',
      ),
      child: Consumer<DialogMaker>(
        builder: (context, model, child) => Scaffold(
          body: Center(
            child: ElevatedButton(
              child: Text('show dialog'),
              onPressed: () => model.showDialog(),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/widgets/i_field.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    Key? key,
    required this.fieldTitle,
    required this.controller,
    this.hintText,
    this.readOnly = false,
  }) : super(key: key);
  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IField(controller: controller, hintText: hintText, readOnly: readOnly),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

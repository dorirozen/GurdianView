import 'package:flutter/material.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:guardian_view/src/profile/edit_profile_form_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm(
      {Key? key,
      required this.fullNameController,
      required this.emailController,
      required this.passwordController,
      required this.oldPasswordController,
      required this.phoneNumController})
      : super(key: key);

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController phoneNumController;

  //File? pickedImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
            fieldTitle: 'Full Name',
            controller: fullNameController,
            hintText: context.currentUser!.fullName),
        EditProfileFormField(
            fieldTitle: 'Email',
            controller: emailController,
            hintText: context.currentUser!.email),
        EditProfileFormField(
            fieldTitle: 'Current Password',
            controller: oldPasswordController,
            hintText: '********'),

        /// now only this part will rebuild
        StatefulBuilder(
          builder: (_, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
                fieldTitle: 'New Password',
                controller: passwordController,
                hintText: '********',
                readOnly: oldPasswordController.text.isEmpty);
          },
        ),
        EditProfileFormField(
            fieldTitle: 'phone number',
            controller: phoneNumController,
            hintText: context.currentUser!.phoneNum),
      ],
    );
  }
}

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/core/common/widgets/gradient_background.dart';
import 'package:guardian_view/core/common/widgets/nested_back_button.dart';
import 'package:guardian_view/core/enums/update_user.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/core/utils/core_utils.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_bloc.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_event.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_state.dart';
import 'package:guardian_view/src/profile/edit_profile_form.dart';

import '../../../../core/resources/media_res.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final phoneNumController = TextEditingController();

  bool _listenersAdded = false;
  // Listener functions will be defined later within the StatefulBuilder
  late void Function() refreshFullName;
  late void Function() refreshEmail;
  late void Function() refreshPassword;
  late void Function() refreshPhoneNum;

  bool get isEmailChanged => emailController.text.trim().isNotEmpty;
  bool get passwordChanged => passwordController.text.trim().isNotEmpty;
  bool get isFullNameChanged =>
      context.currentUser?.fullName.trim() != fullNameController.text.trim();
  bool get isPhoneNumChanged =>
      context.currentUser?.phoneNum?.trim() != phoneNumController.text.trim();
  bool get nothingChanged =>
      !isFullNameChanged &&
      !isEmailChanged &&
      !passwordChanged &&
      !isPhoneNumChanged;
  @override
  void initState() {
    fullNameController.text = context.currentUser!.fullName.trim();
    phoneNumController.text = context.currentUser!.phoneNum?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    if (_listenersAdded) {
      fullNameController.removeListener(refreshFullName);
      emailController.removeListener(refreshEmail);
      passwordController.removeListener(refreshPassword);
      phoneNumController.removeListener(refreshPhoneNum);
    }
    fullNameController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    emailController.dispose();
    phoneNumController.dispose();

    super.dispose();
  }

  void _addListenersIfNeeded(Function refresh) {
    if (!_listenersAdded) {
      // Define listener functions using the refresh callback from StatefulBuilder
      refreshFullName = () => refresh(() {});
      refreshEmail = () => refresh(() {});
      refreshPassword = () => refresh(() {});
      refreshPhoneNum = () => refresh(() {});

      fullNameController.addListener(refreshFullName);
      emailController.addListener(refreshEmail);
      passwordController.addListener(refreshPassword);
      phoneNumController.addListener(refreshPhoneNum);

      _listenersAdded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoading) {
          const CircularProgressIndicator();
        }
        if (state is AuthStateUpdateUser) {
          Navigator.pop(context);
          CoreUtils.showSnackBar(context, 'Profile updated successfully');
        } else if (state is AuthStateError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: const NestedBackButton(),
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) Navigator.pop(context); //context.pop();
                  final bloc = context.read<AuthBloc>();
                  if (passwordChanged) {
                    if (oldPasswordController.text.isEmpty) {
                      CoreUtils.showSnackBar(
                          context, 'Please enter your old password');
                      return;
                    }
                    bloc.add(
                      AuthEventUpdateUser(
                          userData: jsonEncode({
                            'oldPassword': oldPasswordController.text.trim(),
                            'newPassword': passwordController.text.trim()
                          }),
                          action: UpdateUserAction.password),
                    );
                  }
                  if (isFullNameChanged) {
                    bloc.add(
                      AuthEventUpdateUser(
                          userData: fullNameController.text.trim(),
                          action: UpdateUserAction.displayName),
                    );
                  }
                  if (isEmailChanged) {
                    bloc.add(
                      AuthEventUpdateUser(
                          userData: emailController.text.trim(),
                          action: UpdateUserAction.email),
                    );
                  }
                  if (isPhoneNumChanged) {
                    bloc.add(
                      AuthEventUpdateUser(
                          userData: phoneNumController.text.trim(),
                          action: UpdateUserAction.phoneNum),
                    );
                  }
                },
                child: state is AuthStateLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : StatefulBuilder(builder: (_, refresh) {
                        _addListenersIfNeeded(refresh);

                        /// set the state and then nothingChanged will be with diff value
                        return Text(
                          'Done',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: nothingChanged
                                  ? Colors.grey
                                  : Colors.blueAccent),
                        );
                      }),
              ),
            ],
          ),
          body: GradientBackGround(
            image: MediaRes.image3,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(
                  height: 180,
                ),
                EditProfileForm(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    oldPasswordController: oldPasswordController,
                    phoneNumController: phoneNumController),
              ],
            ),
          ),
        );
      },
    );
  }
}

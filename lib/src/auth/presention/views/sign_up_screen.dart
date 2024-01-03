import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/core/common/app/providers/user_provider.dart';
import 'package:guardian_view/core/common/widgets/gradient_background.dart';
import 'package:guardian_view/core/common/widgets/rounded_button.dart';
import 'package:guardian_view/core/resources/colors.dart';
import 'package:guardian_view/core/resources/fonts.dart';
import 'package:guardian_view/core/resources/media_res.dart';
import 'package:guardian_view/core/utils/core_utils.dart';
import 'package:guardian_view/src/auth/data/models/user_model.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_bloc.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_event.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_state.dart';
import 'package:guardian_view/src/auth/presention/views/sign_in_screen.dart';
import 'package:guardian_view/src/auth/presention/widgets/sign_up_form.dart';
import 'package:guardian_view/src/dashboard/views/dash_board.dart';

/// TODO: to change that only the admin can create that
/// + change the form to fill..
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routeName = '/sign-up';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthStateError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is AuthStateSignedUp) {
            context.read<AuthBloc>().add(AuthEventSignIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim()));

            /// initUser here because if he just signedUp..
            /// in the [ router ] its for get into the app from the [ start ] !!
          } else if (state is AuthStateSignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, DashBoardScreen.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackGround(
              image: MediaRes.image3,
              child: SafeArea(
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const Text(
                        'Easy to learn, discover more skills.',
                        style: TextStyle(
                          fontFamily: Fonts.beautiful_people,
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'sign Up for an account',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              SignInScreen.routeName,
                            );
                          },
                          child: const Text('Already have an account ?'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SignUpForm(
                          emailController: emailController,
                          passwordController: passwordController,
                          fullNameController: fullNameController,
                          confirmPasswordController: confirmPasswordController,
                          formKey: formKey),
                      const SizedBox(
                        height: 10,
                      ),
                      state is AuthStateLoading
                          ? const Center(child: CircularProgressIndicator())
                          : RoundedButton(
                              label: 'Sign Up',
                              buttonColor: MyColors.primaryColor,
                              labelColor: Colors.white,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                FirebaseAuth.instance.currentUser?.reload();
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        AuthEventSignUp(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          name: fullNameController.text.trim(),
                                        ),
                                      );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

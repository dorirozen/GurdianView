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
import 'package:guardian_view/src/auth/presention/views/sign_up_screen.dart';
import 'package:guardian_view/src/auth/presention/widgets/sign_in_form.dart';
import 'package:guardian_view/src/dashboard/views/dash_board.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const routeName = '/sign-in';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthStateError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is AuthStateSignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            debugPrint('from sign in');
            /*
            final u = context.read<UserProvider>().user;
            debugPrint('LocalUser{uid: ${u?.uid}, email: ${u?.email}, bio: '
                '${u?.bio}, points: ${u?.points}, fullName: ${u?.fullName}, profilePic: ${u?.profilePic}');
             */
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'sign In to your account',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Baseline(
                            baseline: 100,
                            baselineType: TextBaseline.alphabetic,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  SignUpScreen.routeName,
                                );
                              },
                              child: const Text('Register account ?'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SignInForm(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: formKey),
                      const SizedBox(
                        height: 10,
                      ),
                      state is AuthStateLoading
                          ? const Center(child: CircularProgressIndicator())
                          : RoundedButton(
                              label: 'Sign In',
                              buttonColor: MyColors.primaryColor,
                              labelColor: Colors.white,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                FirebaseAuth.instance.currentUser?.reload();
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        AuthEventSignIn(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
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

import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/widgets/gradient_background.dart';
import 'package:guardian_view/core/resources/media_res.dart';
import 'package:guardian_view/src/profile/refactors/profile_app_bar.dart';
import 'package:guardian_view/src/profile/refactors/profile_body.dart';
import 'package:guardian_view/src/profile/refactors/profile_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const ProfileAppBar(),
      body: GradientBackGround(
        toUse: false,
        image: MediaRes.image4,
        child: ListView(
          padding: const EdgeInsets.all(40),
          scrollDirection: Axis.vertical,
          children: const [
            SizedBox(
              height: 30,
            ),
            ProfileHeader(), // shows some details of the user
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}

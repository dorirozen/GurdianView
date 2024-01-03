import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guardian_view/core/common/app/providers/user_provider.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_bloc.dart';
import 'package:guardian_view/src/profile/widgets/admin/admin_button.dart';
import 'package:guardian_view/src/profile/edit_profile_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //for user
            if (!context.userProvider.user!.isAdmin) ...[
              CoustomButton(
                label: 'Changed something ?',
                icon: IconlyLight.paper_upload,
                // bottom sheet
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      showDragHandle: false,
                      elevation: 0,
                      useSafeArea: true,
                      builder: (_) => BlocProvider(
                            create: (_) => sl<AuthBloc>(),
                            child: const EditProfileView(),
                          ));
                },
              ),
            ],
            if (context.userProvider.user!.isAdmin) ...[
              CoustomButton(
                label: 'User setting',
                icon: IconlyLight.setting,
                onPressed: () {},
              ),
              SizedBox(
                height: 10.0.h,
              ),
              CoustomButton(
                label: 'Camera setting',
                icon: IconlyLight.setting,
                onPressed: () {},
              ),
              SizedBox(
                height: 10.0.h,
              ),
              CoustomButton(
                label: 'Global system setting',
                icon: IconlyLight.setting,
                onPressed: () {},
              ),
              SizedBox(
                height: 10.0.h,
              ),
            ],
          ],
          //UserInfoCard(infoThemeColor,infoIcon,infoTitle,infoValue)
        );
      },
    );
  }
}

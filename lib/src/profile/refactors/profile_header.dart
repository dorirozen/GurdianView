import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/app/providers/user_provider.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      final user = provider.user;
      final city = user?.city == null || user!.city.isEmpty ? null : user.city;
      final coworker = user?.coworkers == null || user!.coworkers.isEmpty
          ? null
          : user.coworkers;

      return Column(
        children: [
          Text(
            user?.fullName ?? 'No User',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          if (user?.phoneNum != null && user!.phoneNum.isNotEmpty) ...[
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * .15,
              ),
              child: Text(
                city!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
          const Text('here will be the details of the user.'),
          if (user?.coworkers != null && user!.coworkers.isNotEmpty) ...[
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * .15,
              ),
              child: Text(
                'here will be coworkers details',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
        ],
      );
    });
  }
}

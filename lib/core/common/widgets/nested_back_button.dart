
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({Key? key}) : super(key: key);

  Icon checkWhichIcon(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return const Icon(Icons.arrow_back_ios_new);
    }
    if (Theme.of(context).platform == TargetPlatform.android) {
      return const Icon(Icons.arrow_back);
    }
    return const Icon(Icons.arrow_back_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        try {
          context.pop();
          return false;
        } catch (_) {
          return true;
        }
      },
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          try {
            context.pop();
            return;
          } catch (_) {
            Navigator.of(context).pop();
          }
        }
      },
      */
      onWillPop: () async {
        try {
          context.pop();
          return false;
        } catch (_) {
          return true;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();

            /// will throw an exception of no found a provider of type ...
            /// because there will not have a close provider in the widget tree
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        //defaultTargetPlatform == TargetPlatform.windows
        icon: checkWhichIcon(context),
      ),
    );
  }
}

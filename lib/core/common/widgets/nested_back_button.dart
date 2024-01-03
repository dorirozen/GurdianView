
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
    ///if the user will press on the back button ! on his phone ! and not on our back button..
    ///we can be thrown to a black screen.. so ! we use canPop and wrap the icon
    // TODO: Needs to check in the future if its working ( can work )!!
    // TODO: 2:46:15 / 3:44:47 in video part 4 .
    return WillPopScope(
      /*
    return PopScope(
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

/*
import 'package:eduction_app/core/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        try {
          context.pop();
        } catch (_) {
          Navigator.of(context).pop();
        }
      },
      //defaultTargetPlatform == TargetPlatform.windows
      icon: Theme.of(context).platform == TargetPlatform.iOS
          ? const Icon(Icons.arrow_back_ios_new)
          : const Icon(Icons.arrow_back),
    );
  }
}
*/


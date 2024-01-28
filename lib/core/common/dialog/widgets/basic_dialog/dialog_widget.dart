import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/dialog/entities/dialog_entities.dart';
import 'package:guardian_view/core/enums/dialog_enums/enums.dart';
import 'package:guardian_view/core/resources/box_texr.dart';
import 'package:guardian_view/core/resources/colors.dart';
import 'package:guardian_view/core/resources/screen_size.dart';
import 'package:guardian_view/core/resources/spacing.dart';

class BasicDialog extends StatelessWidget {
  const BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);
  final DialogRequest request;
  final Function(DialogResponse) completer;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _BasicDialogContect(
        request: request,
        completer: completer,
      ),
    );
  }
}

class _BasicDialogContect extends StatelessWidget {
  const _BasicDialogContect(
      {Key? key, required this.request, required this.completer})
      : super(key: key);
  final DialogRequest request;
  final Function(DialogResponse) completer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidthPercentage(context, percentage: 0.04),
          ),
          padding: EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpaceSmall,
              BoxText.subheading(
                request.title ?? '',
                align: TextAlign.center,
              ),
              verticalSpaceSmall,
              BoxText.body(
                request.description ?? '',
                align: TextAlign.center,
              ),
              verticalSpaceMedium,

              /// buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (request.secondaryButtonTitle != null)
                    TextButton(
                        onPressed: () =>
                            completer(DialogResponse(confirmed: false)),
                        child: BoxText.body(
                          request.secondaryButtonTitle!,
                          color: Colors.black,
                        )),
                  TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: true)),
                      child: BoxText.body(
                        request.mainButtonTitle ?? '',
                        color: MyColors.kcPrimaryColor,
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: -28,
            child: CircleAvatar(
              minRadius: 16,
              maxRadius: 28,
              backgroundColor: _getStausColor(request.statusData),
              child: Icon(
                _getStatusIcon(request.statusData),
                size: 28,
                color: Colors.white,
              ),
            )),
      ],
    );
  }

  Color _getStausColor(dynamic customData) {
    switch (customData) {
      case BasicDialogStatus.error:
        return MyColors.kcRedColor;
      case BasicDialogStatus.warning:
        return MyColors.kcOrangeColor;
      default:
        return MyColors.kcPrimaryColor;
    }
  }

  IconData _getStatusIcon(dynamic customData) {
    switch (customData) {
      case BasicDialogStatus.error:
        return Icons.close;
      case BasicDialogStatus.warning:
        return Icons.warning_amber;
      default:
        return Icons.check;
    }
  }
}

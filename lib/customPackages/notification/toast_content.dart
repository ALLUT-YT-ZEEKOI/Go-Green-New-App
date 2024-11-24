import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

class ToastContent extends StatelessWidget {
  const ToastContent({
    Key? key,
    this.title,
    required this.description,
    required this.notificationType,
    required this.displayCloseButton,
    required this.onCloseButtonPressed,
    this.closeButton,
    this.icon,
    this.iconSize = 20,
    this.action,
    this.onActionPressed,
  }) : super(key: key);

  ///The title of the notification if any
  ///
  final Widget? title;

  ///The description of the notification text string
  ///
  final Widget description;

  ///The notification icon
  final Widget? icon;

  ///The icon size on pixels
  ///
  final double iconSize;

  ///The type of the notification, will be set automatically on every constructor
  ///possible values
  ///```dart
  ///{
  ///SUCCESS,
  ///ERROR,
  ///INFO,
  ///CUSTOM
  ///}
  ///```
  final NotificationType notificationType;

  ///The function invoked when pressing the close button
  ///
  final void Function() onCloseButtonPressed;

  ///Display or hide the close button widget
  ///
  final bool displayCloseButton;

  ///Display or hide the close button widget
  final Widget Function(void Function() dismissNotification)? closeButton;

  ///Action widget rendered with clickable inkwell
  ///by default `action == null`
  final Widget? action;

  ///Function invoked when pressing `action` widget
  ///must be not null when `action != null`
  final Function()? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (size.width - 60) * 0.9,
          child: description,
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     // if (title != null) ...[
        //     //   title!,
        //     //   const SizedBox(
        //     //     height: 5,
        //     //   ),
        //     // ],
        //     description,
        //     if (action != null) ...[
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       onActionPressed == null
        //           ? action!
        //           : InkWell(
        //               onTap: onActionPressed,
        //               child: action!,
        //             )
        //     ]
        //   ],
        // ),
        Visibility(
          visible: displayCloseButton,
          child: closeButton?.call(onCloseButtonPressed) ??
              InkWell(
                onTap: () {
                  onCloseButtonPressed.call();
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
        )
      ],
    );
  }
}

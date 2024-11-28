import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  /// Passing in values for [leftButtonIcon] or [rightButtonIcon] will override [headerIconColor]
  const CalendarHeader(
      {super.key,
      required this.headerTitle,
      this.headerMargin,
      required this.showHeader,
      this.headerTextStyle,
      this.showHeaderButtons = true,
      this.headerIconColor,
      this.leftButtonIcon,
      this.rightButtonIcon,
      required this.onLeftButtonPressed,
      required this.onRightButtonPressed,
      this.onHeaderTitlePressed})
      : isTitleTouchable = onHeaderTitlePressed != null;

  final String headerTitle;
  final EdgeInsetsGeometry? headerMargin;
  final bool showHeader;
  final TextStyle? headerTextStyle;
  final bool showHeaderButtons;
  final Color? headerIconColor;
  final Widget? leftButtonIcon;
  final Widget? rightButtonIcon;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;
  final bool isTitleTouchable;
  final VoidCallback? onHeaderTitlePressed;

  TextStyle get getTextStyle =>
      headerTextStyle ??
      const TextStyle(
        color: Colors.black,
        fontSize: 12.48,
      );

  Widget _leftButton() => IconButton(
        onPressed: onLeftButtonPressed,
        icon: const Icon(Icons.arrow_back),
      );

  Widget _rightButton() => InkWell(
        onTap: onRightButtonPressed,
        child: Container(
            width: 28.08,
            height: 28.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.70),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2e695f97),
                  blurRadius: 11.31,
                  offset: Offset(1.08, 6.15),
                ),
              ],
              color: Colors.white,
            ),
            child: Center(
              child: Transform.rotate(angle: 180 * (3.1415926535 / 180), child: const Icon(Icons.arrow_back)),
            )),
      );

  Widget _headerTouchable() => TextButton(
        onPressed: onHeaderTitlePressed,
        child: Text(
          headerTitle,
          semanticsLabel: headerTitle,
          style: getTextStyle,
        ),
      );

  @override
  Widget build(BuildContext context) => showHeader
      ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: headerMargin,
          child: DefaultTextStyle(
              style: getTextStyle,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                isTitleTouchable ? _headerTouchable() : Text(headerTitle, style: getTextStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    showHeaderButtons ? _leftButton() : Container(),
                    showHeaderButtons ? _rightButton() : Container(),
                  ],
                ),
              ])),
        )
      : Container();
}

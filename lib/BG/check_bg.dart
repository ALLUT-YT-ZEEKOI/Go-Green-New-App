import 'package:flutter/material.dart';
import 'package:gogreen_lite/ExtraWidgets/home_bottom_bar.dart';

class CheckBg extends StatelessWidget {
  const CheckBg({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xFF308CEF),
        shadowColor: Colors.transparent,
      ),
      body: Stack(children: [child, const HomeBottomBar()]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gogreen_lite/ExtraWidgets/home_bottom_bar.dart';

class ProductBg extends StatelessWidget {
  const ProductBg({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: const Color(0xFF308CEF), shadowColor: Colors.transparent),
      body: SizedBox(height: size.height, child: Stack(children: [child, const HomeBottomBar()])),
    );
  }
}

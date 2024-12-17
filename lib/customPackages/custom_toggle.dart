import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Allproviders/main_provider.dart';

class CustomToggle extends StatelessWidget {
  const CustomToggle({
    Key? key,
    this.v1 = 'This Month',
    this.v2 = 'Last Month',
    this.v3 = 'Last 90 Days',
    this.width,
    this.clr,
    required this.f1,
    required this.f2,
    required this.f3,
  }) : super(key: key);
  final String v1;
  final String v2;
  final String v3;
  final Function() f1;
  final Function() f2;
  final Function() f3;
  final double? width;
  final Color? clr;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width * 0.85,
      height: 64,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width ?? size.width * 0.85,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(36.50), color: clr ?? const Color(0xffdfdada)),
            padding: const EdgeInsets.all(
              5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(onTap: f1, child: provider.transactionIndex == 1 ? OnWidget(size: size, value: v1) : OfWidget(value: v1)),
                const SizedBox(width: 10),
                InkWell(onTap: f2, child: provider.transactionIndex == 2 ? OnWidget(size: size, value: v2) : OfWidget(value: v2)),
                const SizedBox(width: 19),
                InkWell(onTap: f3, child: provider.transactionIndex == 3 ? OnWidget(size: size, value: v3) : OfWidget(value: v3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnWidget extends StatelessWidget {
  const OnWidget({
    Key? key,
    required this.size,
    required this.value,
  }) : super(key: key);

  final Size size;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.25,
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.25,
            height: 40,
            decoration: ShapeDecoration(
                color: const Color(0xFF051F32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                shadows: const [BoxShadow(color: Color(0x3529263A), blurRadius: 22, offset: Offset(0, 8), spreadRadius: 0)]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(value, textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: "Montserrat", fontWeight: FontWeight.w700))],
            ),
          )
        ],
      ),
    );
  }
}

class OfWidget extends StatelessWidget {
  const OfWidget({
    Key? key,
    required this.value,
  }) : super(key: key);
  final String value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.25,
        child: Text(
          value,
          textScaler: TextScaler.noScaling,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF051F32), fontSize: 12, fontFamily: "Montserrat", fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

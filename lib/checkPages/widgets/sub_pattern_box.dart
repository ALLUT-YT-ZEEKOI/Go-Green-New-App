import 'package:flutter/material.dart';

class SubPatternBox extends StatelessWidget {
  const SubPatternBox({
    super.key,
    required this.label,
    required this.active,
    required this.ontap,
  });
  final String label;
  final bool active;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 27.5,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: active ? const Color(0xFF2F9623) : const Color(0xFF909090)), borderRadius: BorderRadius.circular(5.90), color: active ? const Color(0xFFEFFFED) : null),
        child: TextButton(
          onPressed: ontap,
          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.90))),
          child: Center(
              child: Text(label,
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(color: active ? const Color(0xFF2F9623) : const Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
        ));
  }
}

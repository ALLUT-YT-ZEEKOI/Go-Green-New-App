import 'package:flutter/material.dart';

class InstructionBox extends StatelessWidget {
  const InstructionBox({super.key, required this.lable, required this.icon, required this.selected, required this.onpressed});

  final String lable;
  final String icon;
  final bool selected;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width - 80) / 2,
      height: 37,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: selected ? const Color(0xFF2F9623) : const Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(7),
      ),
      child: MaterialButton(
        onPressed: onpressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(icon, color: selected ? const Color(0xFF2F9623) : const Color(0xFF1D2730), height: 20),
            const SizedBox(width: 5),
            Text(lable,
                textScaler: TextScaler.noScaling,
                style: TextStyle(color: selected ? const Color(0xFF2F9623) : const Color(0xFF1D2730), fontSize: 9.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

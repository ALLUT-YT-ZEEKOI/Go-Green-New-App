import 'package:flutter/material.dart';

class StepperButton extends StatelessWidget {
  const StepperButton({super.key, required this.f1, required this.f2, required this.val, this.clr = const Color(0xFF2F9623), this.width = 90, this.height = 30});
  final Function() f1;
  final Function() f2;
  final int val;
  final Color clr;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.74, color: clr),
        borderRadius: BorderRadius.circular(5.90),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(onTap: f1, child: Center(child: Container(width: 10, height: 2, color: clr, margin: const EdgeInsets.symmetric(horizontal: 5)))),
          Text('$val', textScaler: TextScaler.noScaling, style: TextStyle(color: clr, fontSize: 14.02, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          InkWell(
            onTap: f2,
            child: Icon(Icons.add, color: clr, size: 20),
          ),
        ],
      ),
    );
  }
}

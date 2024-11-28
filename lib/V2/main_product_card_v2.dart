import 'package:flutter/material.dart';

class MainProductCardV2 extends StatelessWidget {
  const MainProductCardV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 100.02,
            height: 88.47,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.62,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFD9D9D9),
                ),
                borderRadius: BorderRadius.circular(8.68),
              ),
            ),
            child: Image.asset('assets/v2 Images/lays 10.png'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MainProductCardV2 extends StatelessWidget {
  const MainProductCardV2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        for (int i = 0; i <= 2; i++)
          Container(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
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
                  child: Image.asset(
                    'assets/v2 Images/lays 10.png',
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: screenWidth * .2,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE5FCE3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.76),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4.23,
                        height: 4.27,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF305C25),
                          shape: OvalBorder(),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'Enhances ',
                        style: TextStyle(
                          color: Color(0xFF305C25),
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Extra Cheesy Lays \nClassic',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.92,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  '100 g',
                  style: TextStyle(
                    color: Color(0xFF302E2E),
                    fontSize: 8.57,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  '₹ 60-100',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.62,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  '₹ 60',
                  style: TextStyle(
                    color: Color(0xFF9B9999),
                    fontSize: 7.98,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/main_product_card_v2.dart';

class ProductsSreenV2 extends StatelessWidget {
  const ProductsSreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // width: 370,
            height: 306,
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  // width: screenWidth * .9,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: const Row(
                    children: [
                      // Search Icon
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 25,
                        ),
                      ),
                      // Search Text Field
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF959595),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search “condom”',
                            hintStyle: TextStyle(
                              color: Color(0xFF959595),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * 0.3,
                      height: 3,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, 0.00),
                          end: Alignment(-1, 0),
                          colors: [Color(0xFFF3F3F3), Colors.white],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const Text(
                      'Farm Fresh Picks',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Container(
                        width: screenWidth * 0.3,
                        height: 3,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(1.00, 0.00),
                            end: Alignment(-1, 0),
                            colors: [Color(0xFFF3F3F3), Colors.white],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const MainProductCardV2()
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

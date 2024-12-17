import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/v2_provider.dart';
import 'package:gogreen_lite/V2/products_sreen_v2.dart';
import 'package:provider/provider.dart';

class HomePageFirstCourcelV2 extends StatelessWidget {
  const HomePageFirstCourcelV2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final mainProvider = Provider.of<Functions_v2>(context);
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: screenHeight * 0.1 + 7,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                mainProvider.updateCaroselindex(index);
              }),
          items: [1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    padding: const EdgeInsets.all(8),

                    // margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE6F8FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/v2 Images/Group 17211 1.png',
                              width: 50.0,
                              height: 45.0,
                            ),
                            const Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Get farm fresh milk delivered \n',
                                      style: TextStyle(
                                        color: Color(0xFF202020),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'at your Door Step',
                                      style: TextStyle(
                                        color: Color(0xFF202020),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const CustomElevatedButton()
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < 3; i++)
                              mainProvider.caroselindex == i
                                  ? Container(
                                      width: 15,
                                      height: 5,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF00B761),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      width: 5,
                                      height: 5,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFDDD9D9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                          ],
                        ),
                      ],
                    ));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductsSreenV2()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF037ABC),
        backgroundColor: const Color(0xFFD2EEFF),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.93,
            color: Color(0xFF037ABC),
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(12.97),
        ),
        // fixedSize: const Size(87.10, 30),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Subscribe',
          style: TextStyle(
            color: Color(0xFF037ABC),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

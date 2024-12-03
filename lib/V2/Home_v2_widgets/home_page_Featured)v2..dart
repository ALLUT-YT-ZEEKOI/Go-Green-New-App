import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/v2_provider.dart';
import 'package:provider/provider.dart';

class HomePageFeaturedv2 extends StatelessWidget {
  const HomePageFeaturedv2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final mainProvider = Provider.of<Functions_v2>(context);

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: screenHeight * .2 + 50,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              mainProvider.updateCaroselindex(index);
            },
          ),
          items: [1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDEDED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Easiest way to',
                                style: TextStyle(
                                  color: Color(0xFF2383B8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Refer And Earn!',
                                style: TextStyle(
                                  color: const Color(0xFF1A232E),
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Earn for each referral,and \n enjoy up to 2500 GGO Money.',
                                style: TextStyle(
                                  color: const Color(0xFF1A232E),
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/v2 Images/budget 1.png',
                            width: 100,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(screenWidth: screenWidth),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: mainProvider.caroselindex == i ? 15 : 5,
                height: 5,
                decoration: ShapeDecoration(
                  color: mainProvider.caroselindex == i
                      ? const Color(0xFF00B761)
                      : const Color(0xFFDDD9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final double screenWidth;

  const CustomElevatedButton({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.9,
      height: 55,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF2382B7),
          backgroundColor: const Color(0xFF2382B7),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.93,
              color: Color(0xFF037ABC),
            ),
            borderRadius: BorderRadius.circular(12.97),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Refer Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class NextDeliveryBox extends StatelessWidget {
  const NextDeliveryBox({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Next \nDelivery in', style: TextStyle(color: Color(0xFF1D2730), fontSize: 32, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          const SizedBox(height: 30),
          SizedBox(
            child: Stack(children: [
              Positioned(
                right: 0,
                bottom: 25,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircularPercentIndicator(
                        radius: 80,
                        lineWidth: 15,
                        reverse: true,
                        percent: .75,
                        center: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 35),
                            Text('2', style: TextStyle(color: Color(0xFF1D2730), fontSize: 60, fontFamily: 'Poppins', fontWeight: FontWeight.w700, height: 0.9)),
                            Text('days', style: TextStyle(color: Color(0xFF9F9F9F), fontSize: 25, fontFamily: 'Poppins', fontWeight: FontWeight.w400, height: 0.7)),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 30,
                      child: Container(
                        width: 47,
                        height: 46,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Color(0xFF2F9623)),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text('Qty', style: TextStyle(color: Color(0xFF9F9F9F), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                            Text('500ML', style: TextStyle(color: Color(0xFF1D2730), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.2),
                child: Image.asset(
                  'assets/milk2.png',
                  height: 250,
                  width: size.width,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

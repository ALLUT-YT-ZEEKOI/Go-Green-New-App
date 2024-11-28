import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:provider/provider.dart';

import '../../extrafunctions.dart';

class SubscribeBanner extends StatelessWidget {
  const SubscribeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      width: size.width,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(begin: Alignment(0.00, -1.00), end: Alignment(0, 1), colors: [Color(0xFFA7D1FF), Color(0xFF1569E5)]),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/milk.png', height: 280),
          const Text(
            'Explore our organic \nMilk directly from farmers.',
            textScaler: TextScaler.noScaling,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset('assets/icons/from.png', height: 20),
              Container(
                  width: 100,
                  height: 35,
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(color: const Color(0xFFADCFFF), borderRadius: BorderRadius.circular(45)),
                  child: Image.asset('assets/icons/gg-logo-1.png'))
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: size.width,
            height: 60,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)]),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
              onPressed: () {
                mainProvider.innerpageIndex = 0;
                mainProvider.pageType = 1;
                mainProvider.notify();
                facebookAppEvents.logEvent(name: 'home');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Subscribe',
                      textScaler: TextScaler.noScaling, textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF00557F), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  Image.asset('assets/icons/mdi_drop.png', height: 30)
                ]),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

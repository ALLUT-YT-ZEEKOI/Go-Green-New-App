import 'package:flutter/material.dart';

import 'Allproviders/main_provider.dart';
import 'Allproviders/object.dart';

Widget verticalDot = Container(width: 1, height: 13, decoration: ShapeDecoration(color: const Color(0xFFD9D9D9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(93))));

Widget userhorizontalLine = Container(height: 2, color: const Color(0x111D2730), margin: const EdgeInsets.symmetric(horizontal: 15));
Widget userhorizontalLine2 = Container(height: 2, color: const Color(0x111D2730));

Widget productFarmerBox(Size size, MainProvider mainProvider, int index, SubProduct product) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    width: size.width / 2.5,
    height: (size.width / 2.5) + 10,
    decoration:
        BoxDecoration(color: const Color(0xFF1469E5), borderRadius: BorderRadius.circular(8), border: Border.all(color: mainProvider.scrollSnapListIndex == index ? Colors.white : Colors.transparent)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset('assets/Farmer.png', height: 75),
          mainProvider.scrollSnapListIndex == index
              ? Image.asset('assets/milk-bottle.png', height: 50)
              : Padding(padding: const EdgeInsets.only(bottom: 8), child: Image.asset('assets/milk-bottle2.png', height: 40))
        ],
      ),
      const SizedBox(height: 20),
      Text(
        product.sellername,
        textScaler: TextScaler.noScaling,
        style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      Text('₹${product.calculateDiscountedPrice()}/${product.unit}',
          textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400))
    ]),
  );
}

Widget invoiceSummry({required String label, required String val}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF676767), fontSize: 10.50, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
        Expanded(
            child: Text(val,
                textScaler: TextScaler.noScaling, textAlign: TextAlign.end, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))
      ],
    ),
  );
}

Widget invoiceSummryBold({required String label, required String val}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF676767), fontSize: 10.50, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        Expanded(
            child: Text(val,
                textScaler: TextScaler.noScaling, textAlign: TextAlign.end, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w700)))
      ],
    ),
  );
}

//  for checkout
List<CustomPatern> custom = [
  CustomPatern(label: 'SU', name: "Sunday", qty: 1),
  CustomPatern(label: 'M', name: "Monday", qty: 1),
  CustomPatern(label: 'TU', name: "Tuesday", qty: 1),
  CustomPatern(label: 'W', name: "Wednesday", qty: 1),
  CustomPatern(label: 'TH', name: "Thursday", qty: 1),
  CustomPatern(label: 'F', name: "Friday", qty: 1),
  CustomPatern(label: 'SA', name: "Saturday", qty: 1),
];
List<String> pattern = ['One TIme', 'Daily', 'Alternate', 'Custom'];
// List<String> schedule = ['6am - 8am', '4pm - 6pm'];
List<String> schedule = ['6am - 8am'];

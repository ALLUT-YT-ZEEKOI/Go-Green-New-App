import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';

class AddressDisplay extends StatelessWidget {
  const AddressDisplay({super.key, required this.address});
  final UserAddress address;
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
    Future<String?> delete() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: const Text('Delete Address', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500)),
            content: const Text('Are you sure you want to delete this address'),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(width: 70, child: MaterialButton(onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, child: const Text('NO'))),
                SizedBox(
                    width: 70,
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          apiProvider.removeAddress(address);
                        },
                        padding: EdgeInsets.zero,
                        child: const Text('YES')))
              ])
            ],
          ),
        ),
      );
    }

    Future<String?> edit() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: const Text('Edit Address', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500)),
            content: const Text('Are you sure you want to edit this address'),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(width: 70, child: MaterialButton(onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, child: const Text('NO'))),
                SizedBox(
                    width: 70,
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          mainProvider.editCo = LatLong(address.latitude, address.longitude);

                          mainProvider.currentEdit = address;
                          mainProvider.menuInner = 2;
                          mainProvider.menupagetype = 2;
                          mainProvider.notify();
                        },
                        padding: EdgeInsets.zero,
                        child: const Text('YES')))
              ])
            ],
          ),
        ),
      );
    }

    final Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/icons/location.png', height: 40),
        const SizedBox(width: 15),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.address.split(',').toList().first, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                Text(address.address, style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                if (address.addressLine.isNotEmpty) Text(address.addressLine, style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                const SizedBox(height: 5),
                Text('Landmark : ${address.landmark}', style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                Text('Phone number : ${address.phone}', style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 85,
                      height: 30,
                      decoration: BoxDecoration(color: const Color(0xFFE2F0FF), border: Border.all(width: 1.22, color: const Color(0xFF308CEF)), borderRadius: BorderRadius.circular(7.21)),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          onPressed: () => edit(),
                          child: const Center(
                              child: Text('edit', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF308CEF), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 85,
                      height: 30,
                      decoration: BoxDecoration(color: const Color(0xFFFFE8EA), border: Border.all(width: 1.22, color: const Color(0xFFDC3647)), borderRadius: BorderRadius.circular(7.21)),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          onPressed: () => delete(),
                          child: const Center(
                              child: Text('delete', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFDC3647), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))),
                    )
                  ],
                ),
                Row(children: [Container(height: 1.5, margin: const EdgeInsets.symmetric(vertical: 15), width: size.width - 100, color: const Color(0x111D2730))])
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/object.dart';

class LocationSaved extends StatelessWidget {
  const LocationSaved({super.key, required this.address, required this.onpressed});
  final UserAddress address;
  final Function() onpressed;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onpressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/icons/location.png', height: 40),
                const SizedBox(width: 10),
                Flexible(
                    child: Text(address.address.split(',').toList().first,
                        maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w700)))
              ],
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                '${address.address},${address.addressLine}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF909090), fontSize: 11.5, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

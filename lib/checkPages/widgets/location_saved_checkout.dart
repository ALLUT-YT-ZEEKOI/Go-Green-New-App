import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/object.dart';

class LocationSavedCheckout extends StatelessWidget {
  const LocationSavedCheckout({super.key, required this.address, required this.onpressed});
  final UserAddress address;
  final Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/icons/location.png', height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(address.address.split(',').toList().first, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                        const SizedBox(height: 5),
                        Text(
                          '${address.address},${address.addressLine}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Color(0xFF909090), fontSize: 11.5, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                        ),
                        Container(
                          color: const Color(0x111D2730),
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          height: 1.2,
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

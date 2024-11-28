import 'package:flutter/material.dart';

class LocationSavedSelect extends StatelessWidget {
  const LocationSavedSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/location.png', height: 40),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Abad Sait',
                              style: TextStyle(color: Color(0xFF1D2730), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Abad Plaza, house no 6545 Bengaluru, Karnataka,690675. India  sdgdhr',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Color(0xFF909090), fontSize: 11.5, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(Icons.arrow_forward_ios, size: 15),
                      )
                    ],
                  ),
                  Container(height: 1.5, margin: const EdgeInsets.only(top: 20, bottom: 10), color: const Color(0x111D2730))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

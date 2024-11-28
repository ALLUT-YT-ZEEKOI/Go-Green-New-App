import 'package:flutter/material.dart';

import '../../Allproviders/object.dart';
import '../../extrafunctions.dart';

class DairyProducts extends StatelessWidget {
  const DairyProducts({super.key, required this.item});
  final Feed item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2730),
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 80,
          backgroundColor: const Color(0xFF1D2730),
          shadowColor: Colors.transparent,
          leading: Padding(
              padding: const EdgeInsets.only(left: 15), child: InkWell(onTap: () => Navigator.pop(context), child: Image.asset('assets/icons/left-broken.png', width: 40, color: Colors.white)))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: const Color(0xFF1D2730),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: item.imageUrl.isEmpty ? const AssetImage('assets/200x250.png') : NetworkImage(item.imageUrl) as ImageProvider, fit: BoxFit.fill))),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.product, textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                        const SizedBox(height: 10),
                        Container(
                          width: 98,
                          height: 23,
                          decoration: BoxDecoration(color: const Color(0xFFEEFCEC), border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(5.90)),
                          child: Center(
                              child: Text(item.category,
                                  textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF2F9623), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Published by admin', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                    Text(formatDate3(item.createdAt), textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16), // Adding some spacing between the containers
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text('Information', style: TextStyle(color: Color(0xFF1A232E), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          item.desc,
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Color(0xFF1A232E), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 35)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

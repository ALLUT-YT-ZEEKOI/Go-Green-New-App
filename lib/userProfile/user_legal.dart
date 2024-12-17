// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../extrawidgets.dart';

class UserLegal extends StatelessWidget {
  const UserLegal({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFFF6F6F6),
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          launch('https://gogreenocean.com/terms');
                        },
                        leading: Image.asset('assets/icons/contract.png', height: 30),
                        title: const Text('Terms & Conditions', style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                      userhorizontalLine,
                      ListTile(
                        onTap: () {
                          launch('https://gogreenocean.com/return-policy');
                        },
                        leading: Image.asset('assets/icons/contract.png', height: 30),
                        title: const Text('Return Policy', style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                      userhorizontalLine,
                      ListTile(
                        onTap: () {
                          launch('https://gogreenocean.com/support-policy');
                        },
                        leading: Image.asset('assets/icons/contract.png', height: 30),
                        title: const Text('Shipping Policy', style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                      userhorizontalLine,
                      ListTile(
                        onTap: () {
                          launch('https://gogreenocean.com/privacy-policy');
                        },
                        leading: Image.asset('assets/icons/contract.png', height: 30),
                        title: const Text('Privacy Policy', style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

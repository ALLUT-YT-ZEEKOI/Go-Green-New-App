// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extrawidgets.dart';

class UserPage1 extends StatelessWidget {
  const UserPage1({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    Future<String?> logout() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AlertDialog(
            backgroundColor: const Color(0xFFF9FFE7),
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF88AD09)), borderRadius: BorderRadius.circular(12)),
            title: Image.asset('assets/icons/Artboard 26 1.png', height: 120),
            content: const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Leaving the Garden of Wellness?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(255, 212, 178, 178), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              ),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 83.04,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFD1FFCC), border: Border.all(width: 1.22, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      mainProvider.loginIndex = 0;
                      mainProvider.deleteSavedAddress();
                      mainProvider.deleteStoredAddress();
                      apiProvider.logout(context, mainProvider);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('Yes', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF2F9623), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 83.04,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFFFE8EA), border: Border.all(width: 1.22, color: const Color(0xFFDC3647)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('N0', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFDC3647), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    }

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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          mainProvider.menuMain = 1;
                          mainProvider.notify();
                        },
                        leading: Image.asset('assets/icons/setting.png', height: 30),
                        title: const Text('Account & Preferences', textScaler: TextScaler.noScaling, style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                      userhorizontalLine,
                      ListTile(
                        onTap: () {
                          apiProvider.updatewalletReload(true);
                          apiProvider.reloadWallet(0);
                          mainProvider.menuMain = 2;
                          mainProvider.notify();
                        },
                        leading: Image.asset('assets/icons/wallet-1.png', height: 30),
                        title: const Text('Wallet & Payment Modes', textScaler: TextScaler.noScaling, style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                      userhorizontalLine,
                      ListTile(
                          onTap: () => launch("https://wa.me/917397247636"),
                          leading: Image.asset('assets/icons/user-help.png', height: 30),
                          title: const Text('Need Help?', textScaler: TextScaler.noScaling, style: profileFont),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
                      userhorizontalLine,
                      ListTile(
                        onTap: () {
                          mainProvider.menuMain = 3;
                          mainProvider.notify();
                        },
                        leading: Image.asset('assets/icons/legal.png', height: 30),
                        title: const Text('Legal', textScaler: TextScaler.noScaling, style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: size.width,
                margin: const EdgeInsets.only(bottom: 30),
                decoration: ShapeDecoration(color: const Color(0xFFDC3647), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: MaterialButton(
                    onPressed: () => logout(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: const Text('Logout', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600))),
              ),
              const Text('Version 1.4.3(beta)', textScaler: TextScaler.noScaling)
            ],
          )
        ],
      ),
    );
  }
}

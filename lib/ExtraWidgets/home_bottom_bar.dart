import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:provider/provider.dart';

import '../Allproviders/main_provider.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final apiProvider = Provider.of<ApiProvider>(context);
    return Positioned(
        bottom: 0,
        child: Container(
          width: size.width,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
          child: Center(
            child: Container(
              width: size.width,
              height: 70,
              decoration: ShapeDecoration(
                color: const Color(0xFF1A232E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeButtons(
                      icon: 'assets/icons/footer-home.png',
                      label: 'Home',
                      index: 0,
                      ontap: () {},
                    ),
                    HomeButtons(
                      icon: 'assets/icons/footer-sub.png',
                      label: 'Subscription',
                      index: 1,
                      ontap: () {},
                    ),
                    HomeButtons(
                      icon: 'assets/icons/footer-menu.png',
                      label: 'Menu',
                      index: 2,
                      ontap: () {},
                    ),
                    HomeButtons(
                      icon: 'assets/icons/footer-benefit.png',
                      label: 'Benefit',
                      index: 3,
                      ontap: () {
                        apiProvider.updatebenefitsreload(true);
                        apiProvider.getBenefits(false, 0);
                      },
                    ),
                    HomeButtons(
                      icon: 'assets/icons/footer-wallet.png',
                      label: 'Wallet',
                      index: 4,
                      ontap: () {
                        apiProvider.updatewalletReload(true);
                        apiProvider.reloadWallet(0);
                      },
                    ),
                  ]),
            ),
          ),
        ));
  }
}

class HomeButtons extends StatelessWidget {
  const HomeButtons(
      {super.key,
      required this.icon,
      required this.label,
      required this.index,
      required this.ontap});
  final String icon;
  final String label;
  final int index;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return InkWell(
      onTap: () {
        ontap();
        mainProvider.pageType = 0;
        if (mainProvider.homepageIndex != index) {
          mainProvider.homepageIndex = index;
        }
        mainProvider.notify();
      },
      child: SizedBox(
        width: (size.width - 65) / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon,
                height: 30,
                color:
                    mainProvider.homepageIndex == index ? Colors.green : null),
            Text(label,
                textScaler: TextScaler.noScaling,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}

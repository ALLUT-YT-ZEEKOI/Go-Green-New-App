import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:provider/provider.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apirovider = Provider.of<ApiProvider>(context);
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const ShapeDecoration(color: Color(0xFFCDFBC8), shape: OvalBorder()),
                child: Center(child: Container(width: 8, height: 8, decoration: const ShapeDecoration(color: Color(0xFF2F9623), shape: OvalBorder()))),
              ),
              const SizedBox(width: 5),
              const Text('Products and Subscriptions', textScaler: TextScaler.noScaling, style: menuTitle),
            ],
          ),
          Row(
            children: [
              // MenuActionIcon(onPressed: () {}, icon: 'assets/icons/product2.png', label: 'Products'),
              MenuActionIcon(
                  onPressed: () {
                    mainProvider.innerpageIndex = 1;
                    mainProvider.pageType = 1;
                    mainProvider.notify();
                  },
                  icon: 'assets/icons/sub.png',
                  label: 'Subscriptions'),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const ShapeDecoration(color: Color(0xFFCDFBC8), shape: OvalBorder()),
                child: Center(child: Container(width: 8, height: 8, decoration: const ShapeDecoration(color: Color(0xFF2F9623), shape: OvalBorder()))),
              ),
              const SizedBox(width: 5),
              const Text('Orders and Billing', textScaler: TextScaler.noScaling, style: menuTitle),
            ],
          ),
          Row(
            children: [
              MenuActionIcon(
                  onPressed: () {
                    mainProvider.innerpageIndex = 4;
                    mainProvider.pageType = 1;
                    mainProvider.notify();
                  },
                  icon: 'assets/icons/history.png',
                  label: 'Order History'),
              MenuActionIcon(
                  onPressed: () {
                    apirovider.updateTrasactionreload(true);
                    mainProvider.innerpageIndex = 5;
                    mainProvider.pageType = 1;
                    mainProvider.notify();
                    apirovider.getTransaction(1, 0);
                  },
                  icon: 'assets/icons/transaction.png',
                  label: 'Transactions'),
              // MenuActionIcon(onPressed: () {}, icon: 'assets/icons/calendar.png', label: 'Monthly Bill'),
            ],
          ),
          const SizedBox(height: 15),
          // Row(
          //   children: [
          //     Container(
          //       width: 16,
          //       height: 16,
          //       decoration: const ShapeDecoration(color: Color(0xFFCDFBC8), shape: OvalBorder()),
          //       child: Center(child: Container(width: 8, height: 8, decoration: const ShapeDecoration(color: Color(0xFF2F9623), shape: OvalBorder()))),
          //     ),
          //     const SizedBox(width: 5),
          //     const Text('Rewards', style: menuTitle),
          //   ],
          // ),
          // Row(
          //   children: [
          //     MenuActionIcon(onPressed: () {}, icon: 'assets/icons/refer.png', label: 'Refer'),
          //     MenuActionIcon(onPressed: () {}, icon: 'assets/icons/discount.png', label: 'Offer Zone'),
          //   ],
          // )
        ],
      ),
    );
  }
}

class MenuActionIcon extends StatelessWidget {
  const MenuActionIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final String icon;
  final String label;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      child: Center(
        child: MaterialButton(
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Column(
            children: [
              Image.asset(icon, height: 35),
              Text(label, textScaler: TextScaler.noScaling, style: menusub),
            ],
          ),
        ),
      ),
    );
  }
}

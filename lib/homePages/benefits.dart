import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'widgets/dairyproducts.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 35, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          style: IconButton.styleFrom(padding: const EdgeInsets.all(5)),
                          onPressed: () {
                            mainProvider.homepageIndex = 0;
                            mainProvider.notify();
                          },
                          icon: Image.asset('assets/icons/home-fill.png', height: 35)),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Benefits', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF1D2730), fontSize: 25, fontFamily: 'Poppins', fontWeight: FontWeight.w700))),
                Expanded(
                    child: apiProvider.benefitsreload
                        ? const Center(child: CircularProgressIndicator())
                        : apiProvider.benefits.isEmpty
                            ? const Center(child: Text('Nothing to display'))
                            : ListView(padding: EdgeInsets.zero, children: [
                                for (var item in apiProvider.benefits) BenifitItem(item: item),
                                if (apiProvider.benefitsCurrentpage < apiProvider.benefitsFinalpage)
                                  apiProvider.benefitsmorereload
                                      ? const Padding(padding: EdgeInsets.symmetric(vertical: 25), child: Center(child: LinearProgressIndicator(color: Colors.green, minHeight: 1)))
                                      : InkWell(
                                          onTap: () {
                                            apiProvider.updatebenefitsMorereload(true);
                                            apiProvider.getBenefits(true, 0);
                                          },
                                          child: const Icon(Icons.keyboard_arrow_down_outlined, size: 35))
                              ])),
              ],
            ),
          ),
          Positioned(right: 0, child: Image.asset('assets/Group 1 12 (4).png', width: 70))
        ],
      ),
    );
  }
}

class BenifitItem extends StatelessWidget {
  const BenifitItem({super.key, required this.item});
  final Feed item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF1A232E), borderRadius: BorderRadius.only(topLeft: Radius.circular(28), bottomLeft: Radius.circular(28))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 110,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: item.imageUrl.isEmpty ? const AssetImage('assets/200x250.png') : NetworkImage(item.imageUrl) as ImageProvider, fit: BoxFit.fill)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(item.product, textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Container(
                        width: 98,
                        height: 23,
                        decoration: ShapeDecoration(
                            color: const Color(0xFFEEFCEC), shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF2F9623)), borderRadius: BorderRadius.circular(5.90))),
                        child: Center(
                          child:
                              Text(item.category, textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF2F9623), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                                reverseDuration: const Duration(milliseconds: 400), // Adjust the duration as needed
                                child: DairyProducts(item: item)),
                          );
                        },
                        icon: Image.asset('assets/heroicons_arrow-long-right-solid.png', width: 50, height: 50)),
                  ],
                ),
              ],
            ),
          ),
          Text(item.title,
              textScaler: TextScaler.noScaling,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}

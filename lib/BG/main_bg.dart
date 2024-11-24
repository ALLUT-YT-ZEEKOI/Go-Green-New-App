import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/ExtraWidgets/home_bottom_bar.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/extraFunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../user_profile.dart';

class MainBg extends StatefulWidget {
  const MainBg({super.key, required this.child, required this.scaffoldKey});
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<MainBg> createState() => _MainBgState();
}

class _MainBgState extends State<MainBg> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      key: widget.scaffoldKey,

      // drawer: UserProfile(
      //   scaffoldKey: widget.scaffoldKey,
      // ),
      drawerDragStartBehavior: DragStartBehavior.start,
      resizeToAvoidBottomInset: false,
      appBar: mainProvider.pageType == 0 && mainProvider.homepageIndex == 0
          ? AppBar(
              toolbarHeight: 70,
              leading: const SizedBox(width: 0),
              leadingWidth: 0,
              actions: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: const Duration(milliseconds: 400),
                        reverseDuration: const Duration(milliseconds: 400), // Adjust the duration as needed
                        child: UserProfile(
                          scaffoldKey: widget.scaffoldKey,
                        )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(begin: Alignment(0.71, -0.71), end: Alignment(-0.71, 0.71), colors: [Color(0xFF9FBC22), Color(0xFF2F9623)]),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Center(child: Icon(Icons.person, size: 35, color: Colors.white)),
                    ),
                  ),
                )
              ],
              title: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    determinePosition(widget.scaffoldKey.currentContext!);
                    mainProvider.homepageIndex = 5;
                    mainProvider.notify();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/location.png', width: 35),
                          const SizedBox(width: 5),
                          if (mainProvider.pickedSaved != null)
                            Expanded(
                              child: Text(
                                mainProvider.pickedSaved?.address.split(',').toList().first ?? "",
                                style: const TextStyle(color: Color(0xFF1D2730), fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                              ),
                            )
                          else if (mainProvider.pickedAddress != null)
                            Expanded(
                              child: Text(
                                mainProvider.pickedAddress?.subLocality ?? "",
                                style: const TextStyle(color: Color(0xFF1D2730), fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                              ),
                            ),
                          const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.keyboard_arrow_down))
                        ],
                      ),
                      if (mainProvider.pickedSaved != null)
                        Text(
                          '${mainProvider.pickedSaved?.address ?? ""}, ${mainProvider.pickedSaved?.addressLine ?? ""}',
                          style: const TextStyle(color: Color(0xFF909090), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                        )
                      else if (mainProvider.pickedAddress != null)
                        Text(
                          '${mainProvider.pickedAddress?.street ?? ""}, ${mainProvider.pickedAddress?.subLocality ?? ""}, ${mainProvider.pickedAddress?.locality ?? ""}',
                          style: const TextStyle(color: Color(0xFF909090), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                        )
                    ],
                  ),
                ),
              ),
            )
          : AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
            ),

      // body: Stack(children: [child, const HomeBottomBar()]),

      // body: mainProvider.pageType == 0 && mainProvider.homepageIndex == 0
      //     ? NestedScrollView(
      //         headerSliverBuilder: (context, innerBoxIsScrolled) {
      //           return [
      //             SliverAppBar(
      //               toolbarHeight: 80,
      //               actions: [
      //                 InkWell(
      //                   onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
      //                   child: Container(
      //                     margin: const EdgeInsets.fromLTRB(5, 15, 25, 15),
      //                     width: 50,
      //                     height: 50,
      //                     decoration: ShapeDecoration(
      //                       gradient: const LinearGradient(begin: Alignment(0.71, -0.71), end: Alignment(-0.71, 0.71), colors: [Color(0xFF9FBC22), Color(0xFF2F9623)]),
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(100),
      //                       ),
      //                     ),
      //                     child: const Center(child: Icon(Icons.person, size: 35, color: Colors.white)),
      //                   ),
      //                 )
      //               ],
      //               leading: const SizedBox(width: 0),
      //               leadingWidth: 0,
      //               title: Padding(
      //                 padding: const EdgeInsets.only(left: 10),
      //                 child: InkWell(
      //                   onTap: () {
      //                     determinePosition(widget.scaffoldKey.currentContext!);
      //                     mainProvider.homepageIndex = 5;
      //                     mainProvider.notify();
      //                   },
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Row(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Image.asset('assets/icons/location.png', height: 40),
      //                           const Text(
      //                             'Abad Sait',
      //                             style: TextStyle(color: Color(0xFF1D2730), fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
      //                           ),
      //                           const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.keyboard_arrow_down))
      //                         ],
      //                       ),
      //                       const Text(
      //                         'Abad Plaza, Bengaluru, Karnataka....',
      //                         style: TextStyle(color: Color(0xFF909090), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               pinned: false, // Set to true to keep the app bar pinned
      //               floating: true, // Set to false to avoid the app bar floating effect
      //               snap: true, // Set to false for no snapping effect
      //               surfaceTintColor: Colors.white,
      //             ),
      //           ];
      //         },
      //         body: Stack(children: [widget.child, const HomeBottomBar()]),
      //       )
      //     :
      body: Stack(children: [widget.child, if (mainProvider.homepageIndex != 5 && mainProvider.homepageIndex != 1 && mainProvider.homepageIndex != 4) const HomeBottomBar()]),
    );
  }
}

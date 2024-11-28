// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/BG/main_bg.dart';
import 'package:gogreen_lite/checkPages/sample_checkout.dart';
import 'package:gogreen_lite/checkPages/sub_checkout.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:gogreen_lite/homePages/home_menu.dart';
import 'package:gogreen_lite/homePages/home_page.dart';
import 'package:gogreen_lite/userProfile/address_add.dart';
import 'package:provider/provider.dart';

import 'BG/product_bg.dart';
import 'checkPages/add_address_checkout.dart';
import 'checkPages/openSub.dart';
import 'checkPages/sample_summry.dart';
import 'checkPages/summry.dart';
import 'homePages/benefits.dart';
import 'homePages/home_wallet.dart';
import 'homePages/location_page.dart';
import 'inner_pages.dart/location_pick.dart';
import 'inner_pages.dart/location_pick_cordinate.dart';
import 'inner_pages.dart/my_subscription.dart';
import 'inner_pages.dart/order_history.dart';
import 'inner_pages.dart/product_detail_page.dart';
import 'inner_pages.dart/transaction.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});
  static const route = '/home';
  @override
  State<MainHome> createState() => _HomeState();
}

class _HomeState extends State<MainHome> {
  void check(MainProvider provider, ApiProvider apiProvider) async {
    Placemark? data = await provider.retrievecurrentAddress();
    UserAddress? data1 = await provider.retrievesavedAddress();
    if (data1 == null && data == null) {
      provider.homepageIndex = 5;
      setState(() {});
    }
    if (apiProvider.appversion > 36) apiProvider.showUpdate();
  }

  @override
  void initState() {
    super.initState();
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    if (mainProvider.pickedAddress == null) {
      check(mainProvider, apiProvider);
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> homePages = const [
    HomePage(),
    MySub(),
    HomeMenu(),
    BenefitsScreen(),
    HomeWallet(),
    LocationPage()
  ];
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    List<Widget> checkpages = [
      const SubCheckout(),
      const Summry(),
      const OpenSub(),
      const AddressAdd(),
      LocationPickCoordinate(
        onPicked: (pickedData) async {
          await mainProvider.updatePickedAddress(pickedData).then((value) {
            mainProvider.checkpagesIndex = 5;
            mainProvider.notify();
          });
          if (apiProvider.userDetails != null &&
              apiProvider.userDetails!.lastCheckLocationcount < 3) {
            lastAcess(lat: pickedData.latitude, long: pickedData.longitude);
          }
        },
      ),
      const AddressAddCheckout(),
      const SampleCheckout(),
      const SampleSummry(),
    ];

    List<Widget> innerpages = [
      const ProductDetailPage(),
      const MySub(),
      LocationPick(onPicked: (val) {
        mainProvider.pageType = 0;
        mainProvider.homepageIndex = 0;
        mainProvider.updatePickedAddress(val);
        if (apiProvider.userDetails != null &&
            apiProvider.userDetails!.lastCheckLocationcount < 3) {
          lastAcess(lat: val.latitude, long: val.longitude);
        }
      }),
      LocationPickCoordinate(onPicked: (val) {
        mainProvider.pageType = 0;
        mainProvider.homepageIndex = 0;
        mainProvider.updatePickedAddress(val);
        if (apiProvider.userDetails != null &&
            apiProvider.userDetails!.lastCheckLocationcount < 3) {
          lastAcess(lat: val.latitude, long: val.longitude);
        }
      }),
      const OrderHistory(),
      const Trasaction(),
      LocationPickCoordinate(
          load: true,
          onPicked: (val) {
            mainProvider.pageType = 0;
            mainProvider.homepageIndex = 0;
            mainProvider.updatePickedAddress(val);
            if (apiProvider.userDetails != null &&
                apiProvider.userDetails!.lastCheckLocationcount < 3) {
              lastAcess(lat: val.latitude, long: val.longitude);
            }
          }),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (mainProvider.pageType == 0) {
          if (mainProvider.homepageIndex != 0) {
            if (mainProvider.homepageIndex == 5) {
              Placemark? data = await mainProvider.retrievecurrentAddress();
              UserAddress? data1 = await mainProvider.retrievesavedAddress();

              if (data1 != null || data != null) {
                mainProvider.homepageIndex = 0;
              } else {
                return false;
              }
            }
            mainProvider.homepageIndex = 0;
          }
        } else {
          if (mainProvider.pageType == 2 && mainProvider.checkpagesIndex == 1 ||
              mainProvider.checkpagesIndex == 4 ||
              mainProvider.checkpagesIndex == 5) {
            mainProvider.checkpagesIndex = 0;
          } else {
            mainProvider.pageType--;
          }
        }

        mainProvider.notify();
        return false;
      },
      child: mainProvider.pageType == 1 && mainProvider.innerpageIndex == 0
          ? ProductBg(child: innerpages[0])
          : (mainProvider.pageType == 1 && mainProvider.innerpageIndex != 0)
              ? innerpages[mainProvider.innerpageIndex]
              : mainProvider.pageType == 2
                  ? checkpages[mainProvider.checkpagesIndex]
                  : mainProvider.pageType == 0 &&
                          mainProvider.homepageIndex == 3
                      ? homePages[3]
                      : MainBg(
                          scaffoldKey: scaffoldKey,
                          child: mainProvider.pageType == 0
                              ? homePages[mainProvider.homepageIndex]
                              : mainProvider.pageType == 1
                                  ? innerpages[mainProvider.innerpageIndex]
                                  : const SizedBox(),
                        ),
    );
  }
}

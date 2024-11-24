// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:gogreen_lite/inner_pages.dart/location_pick_cordinate_edit.dart';
import 'package:provider/provider.dart';
import 'Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'inner_pages.dart/location_pick.dart';
import 'userProfile/address_add.dart';
import 'userProfile/address_edit.dart';
import 'userProfile/user_account.dart';
import 'userProfile/user_addr.dart';
import 'userProfile/user_legal.dart';
import 'userProfile/user_page1.dart';
import 'userProfile/user_wallet.dart';

const List<Widget> mainPages = [UserPage1(), UserAccount(), UserWallet(), UserLegal()];
const List<Widget> first = [UserAddr()];

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    List<Widget> inner = [
      LocationPick(onPicked: (val) async {
        if (apiProvider.userDetails != null && apiProvider.userDetails!.lastCheckLocationcount < 3) {
          lastAcess(lat: val.latitude, long: val.longitude);
        }

        await mainProvider.updatePickedAddress(val).then((value) {
          mainProvider.menuInner = 1;
          mainProvider.notify();
        });
      }),
      const AddressAdd(),
      LocationPickCoordinateEdit(onPicked: (val) {
        mainProvider.menuInner = 3;
        mainProvider.updatePickedAddress(val);
        if (apiProvider.userDetails != null && apiProvider.userDetails!.lastCheckLocationcount < 3) {
          lastAcess(lat: val.latitude, long: val.longitude);
        }
      }),
      const AddressEdit(),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (mainProvider.menupagetype == 0) {
          if (mainProvider.menuMain == 0) {
            Navigator.pop(context);
          } else {
            mainProvider.menuMain = 0;
            mainProvider.usernameEdit = true;
            mainProvider.useremailEdit = true;
          }
        } else {
          mainProvider.menupagetype--;
        }
        mainProvider.notify();
        return false;
      },
      child: Scaffold(
        appBar: mainProvider.menupagetype == 2 && mainProvider.menuInner == 0
            ? null
            : AppBar(
                title: Text(
                  mainProvider.menupagetype == 0 && mainProvider.menuMain == 0
                      ? 'Profile & Settings'
                      : mainProvider.menupagetype == 0 && mainProvider.menuMain == 1
                          ? 'Account'
                          : mainProvider.menupagetype == 0 && mainProvider.menuMain == 2
                              ? 'Wallet'
                              : mainProvider.menupagetype == 0 && mainProvider.menuMain == 3
                                  ? 'Legal'
                                  : mainProvider.menupagetype == 1 && mainProvider.menuFirst == 0
                                      ? 'Edit/Add Addresses'
                                      : mainProvider.menupagetype == 2 && mainProvider.menuInner == 1
                                          ? 'Add New Addresses'
                                          : mainProvider.menupagetype == 2 && mainProvider.menuInner == 3
                                              ? 'Edit Addresses'
                                              : '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF092C4C),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.36,
                  ),
                ),
                elevation: 0,
                backgroundColor: const Color(0xFFF6F6F6),
                leading: IconButton(
                  icon: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730)),
                  onPressed: () {
                    if (mainProvider.menupagetype == 0) {
                      if (mainProvider.menuMain == 0) {
                        Navigator.pop(context);
                      } else {
                        mainProvider.usernameEdit = true;
                        mainProvider.useremailEdit = true;
                        mainProvider.menuMain = 0;
                      }
                    } else {
                      mainProvider.menupagetype--;
                    }
                    mainProvider.notify();
                  },
                ),
              ),
        body: mainProvider.menupagetype == 0
            ? mainPages[mainProvider.menuMain]
            : mainProvider.menupagetype == 1
                ? first[mainProvider.menuFirst]
                : inner[mainProvider.menuInner],
      ),
    );
  }
}

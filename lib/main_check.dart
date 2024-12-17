import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Login/location.dart';
import 'package:gogreen_lite/Login/otp.dart';
import 'package:gogreen_lite/Login/sign_in.dart';
import 'package:gogreen_lite/main_home.dart';
import 'package:provider/provider.dart';

import 'Login/createaccount.dart';
import 'Login/signinwithphone.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();
const List<Widget> login = [SignIn(), SigninWithPhone(), OtpScreen(), CreateAccount(), LocationScreen()];

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key, required this.islogin, required this.isuser}) : super(key: key);
  final bool islogin;
  final bool isuser;
  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return widget.islogin && widget.isuser
        ? const MainHome()
        : widget.islogin
            ? login[3]
            : login[mainProvider.loginIndex];
  }
}

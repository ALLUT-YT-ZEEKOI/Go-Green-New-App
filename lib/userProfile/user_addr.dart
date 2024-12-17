import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/address_display.dart';

class UserAddr extends StatefulWidget {
  const UserAddr({super.key});

  @override
  State<UserAddr> createState() => _UserAddrState();
}

class _UserAddrState extends State<UserAddr> {
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);

    return Container(
      color: const Color(0xFFF6F6F6),
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 44,
              decoration: BoxDecoration(color: const Color(0xFFF8FFF7), border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(9)),
              child: MaterialButton(
                onPressed: () {
                  mainProvider.menupagetype = 2;
                  mainProvider.menuInner = 0;
                  mainProvider.notify();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const Text('ADD NEW ADDRESS', style: TextStyle(color: Color(0xFF2F9623), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Saved Addresses', style: TextStyle(color: Color(0xFF909090), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
          Expanded(
            child: ListView(
              children: [
                if (apiProvider.addAddressReload) const Padding(padding: EdgeInsets.symmetric(vertical: 25), child: Center(child: LinearProgressIndicator(color: Colors.blue, minHeight: 1))),
                const SizedBox(height: 10),
                for (var i in apiProvider.userAddress) AddressDisplay(address: i)
              ],
            ),
          )
        ],
      ),
    );
  }
}

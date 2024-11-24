import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:provider/provider.dart';

class MyOrderTab extends StatelessWidget {
  const MyOrderTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(color: const Color(0xFFEEFFC1), borderRadius: BorderRadius.circular(10)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabItem(index: 0, label: 'All Orders'),
          TabItem(index: 1, label: 'Deliverd'),
          TabItem(index: 2, label: 'Cancelled'),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.index, required this.label});
  final int index;
  final String label;
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (apiProvider.ordertab != index) {
          apiProvider.updateOrdertab(index);
        }
      },
      child: apiProvider.ordertab == index
          ? Container(
              width: size.width * 0.8 / 3,
              decoration: BoxDecoration(
                gradient: const LinearGradient(begin: Alignment(0.65, -0.76), end: Alignment(-0.65, 0.76), colors: [Color(0xFF96BA24), Color(0xFF5AA524)]),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Color(0x3529263A), blurRadius: 16.42, offset: Offset(0, 5.97), spreadRadius: 0)],
              ),
              child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10.45, fontFamily: 'Poppins', fontWeight: FontWeight.w700))),
            )
          : SizedBox(
              width: size.width * 0.8 / 3, child: Center(child: Text(label, style: const TextStyle(color: Color(0xFF5FA725), fontSize: 10.45, fontFamily: 'Poppins', fontWeight: FontWeight.w700)))),
    );
  }
}

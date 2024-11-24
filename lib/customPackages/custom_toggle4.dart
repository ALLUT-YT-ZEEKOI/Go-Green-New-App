import 'package:flutter/material.dart';

class SubCustomToggle extends StatelessWidget {
  const SubCustomToggle({super.key, this.selected = 0, this.l1 = '', this.l2 = '', this.l3 = '', this.l4 = '', required this.f1, required this.f2, required this.f3, required this.f4});
  final int selected;
  final String l1;
  final String l2;
  final String l3;
  final String l4;
  final Function() f1;
  final Function() f2;
  final Function() f3;
  final Function() f4;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(color: const Color(0xFFEEFFC1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabItem(index: 0, label: l1, selected: selected == 0, onTap: f1),
          TabItem(index: 1, label: l2, selected: selected == 1, onTap: f2),
          TabItem(index: 2, label: l3, selected: selected == 2, onTap: f3),
          TabItem(index: 3, label: l4, selected: selected == 3, onTap: f4),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.index, required this.label, required this.selected, required this.onTap});
  final int index;
  final String label;
  final bool selected;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: selected
          ? Container(
              width: index == 0
                  ? width*0.16
                  : index == 1
                      ? width*0.19
                      : index == 2
                          ? width*0.25
                          : width*0.25,
              decoration: BoxDecoration(
                gradient: const LinearGradient(begin: Alignment(0.65, -0.76), end: Alignment(-0.65, 0.76), colors: [Color(0xFF96BA24), Color(0xFF5AA524)]),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Color(0x3529263A), blurRadius: 16.42, offset: Offset(0, 5.97), spreadRadius: 0)],
              ),
              child: Center(child: Text(label, textScaler: TextScaler.noScaling, style: const TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w700))),
            )
          : SizedBox(
              width: index == 0
                  ?  width*0.16
                  : index == 1
                      ? width*0.19
                      : index == 2
                          ?width*0.25
                          :  width*0.25,
              child: Center(child: Text(label, textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF5FA725), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w700))),
            ),
    );
  }
}

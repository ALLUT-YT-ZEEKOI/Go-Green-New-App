// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Allproviders/main_provider.dart';

class SingleDate extends StatelessWidget {
  const SingleDate({
    Key? key,
    required this.click,
  }) : super(key: key);

  final bool click;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(context: context, initialDate: provider.singleDate, firstDate: DateTime.now(), cancelText: '', lastDate: DateTime(2101));

      if (picked != null) {
        provider.singleDate = picked;
        provider.notify();
      }
      if (picked == null) {
        _selectDate(context);
      }
    }

    return InkWell(
      onTap: () {
        if (click) _selectDate(context);
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${provider.singleDate.day}-${provider.singleDate.month}-${provider.singleDate.year} ',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ]),
    );
  }
}

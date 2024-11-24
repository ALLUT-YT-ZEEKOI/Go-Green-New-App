import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:provider/provider.dart';

class NewLocation extends StatelessWidget {
  const NewLocation({
    super.key,
    required this.address,
  });
  final Address address;
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return InkWell(
      onTap: () {
        mainProvider.seacrchCo = null;
        mainProvider.innerpageIndex = 6;
        mainProvider.pageType = 1;
        mainProvider.getCoordinates(address.placeId!);
        mainProvider.notify();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 5),
                Flexible(
                    child: Text(
                  address.reference!.split(',').first,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text('${address.reference}'),
            ),
          ],
        ),
      ),
    );
  }
}

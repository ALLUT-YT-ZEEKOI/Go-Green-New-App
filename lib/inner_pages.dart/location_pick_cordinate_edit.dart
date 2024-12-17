import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:map_location_picker/map_location_picker.dart' as package;
import '../customPackages/map_location_picker.dart';

class LocationPickCoordinateEdit extends StatelessWidget {
  const LocationPickCoordinateEdit({super.key, required this.onPicked});
  final void Function(LatLong pickedData) onPicked;
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return mainProvider.editCo == null
        ? const Center(child: CircularProgressIndicator())
        : MapLocationPicker(
            apiKey: "AIzaSyD-zFDSMo3Otg25k6NZ0bMZC2xCPIsof5c",
            currentLatLng: package.LatLng(mainProvider.editCo!.latitude, mainProvider.editCo!.longitude),
            hideSuggestionsOnKeyboardHide: true,
            hideBottomCard: false,
            hideBackButton: true,
            bottomCardIcon: const Icon(Icons.done),
            hideMapTypeButton: true,
            minMaxZoomPreference: const package.MinMaxZoomPreference(10, 20),
            onNext: (val) {
              onPicked(LatLong(val!.geometry.location.lat, val.geometry.location.lng));
            },
            hideMoreOptions: true);
  }
}

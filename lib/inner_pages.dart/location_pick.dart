import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:map_location_picker/map_location_picker.dart' as package;
import '../customPackages/map_location_picker.dart';

class LocationPick extends StatelessWidget {
  const LocationPick({super.key, required this.onPicked});
  final void Function(LatLong pickedData) onPicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLocationPicker(
          autofoucs: true,
          apiKey: "AIzaSyD-zFDSMo3Otg25k6NZ0bMZC2xCPIsof5c",
          currentLatLng: const package.LatLng(13.0827, 80.2707),
          hideSuggestionsOnKeyboardHide: true,
          hideBottomCard: false,
          hideBackButton: true,
          bottomCardIcon: const Icon(Icons.done),
          hideMapTypeButton: true,
          getLocation: () {},
          hideLocationButton: false,
          minMaxZoomPreference: const package.MinMaxZoomPreference(10, 20),
          onNext: (val) {
            // print(val!.geometry.location.lat);
            // print(val.geometry.location.lng);
            onPicked(LatLong(val!.geometry.location.lat, val.geometry.location.lng));
          },
          hideMoreOptions: true),
    );
  }
}

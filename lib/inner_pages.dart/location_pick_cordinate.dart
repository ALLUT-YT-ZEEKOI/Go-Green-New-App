import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';

import '../customPackages/map_location_picker.dart';
import 'package:map_location_picker/map_location_picker.dart' as package;

class LocationPickCoordinate extends StatefulWidget {
  const LocationPickCoordinate({super.key, required this.onPicked, this.load = false});
  final void Function(LatLong pickedData) onPicked;
  final bool load;

  @override
  State<LocationPickCoordinate> createState() => _LocationPickCoordinateState();
}

class _LocationPickCoordinateState extends State<LocationPickCoordinate> {
  @override
  void initState() {
    createBorder();
    super.initState();
  }

  Set<package.Polygon> polygons = {};
  void createBorder() {
    List<package.LatLng> borderCoordinates = [
      const package.LatLng(37.7749, -122.4194),
      const package.LatLng(37.7749, -122.5177),
      const package.LatLng(37.7209, -122.5177),
      const package.LatLng(37.7209, -122.4194)
    ];

    // Create the polygon representing the border
    polygons.add(package.Polygon(polygonId: const package.PolygonId('border'), points: borderCoordinates, strokeWidth: 2, strokeColor: Colors.red));
  }

  bool isLocationInsideBorder(package.LatLng location) {
    double minLat = polygons.first.points.map((point) => point.latitude).reduce((a, b) => a < b ? a : b);
    double maxLat = polygons.first.points.map((point) => point.latitude).reduce((a, b) => a > b ? a : b);
    double minLng = polygons.first.points.map((point) => point.longitude).reduce((a, b) => a < b ? a : b);
    double maxLng = polygons.first.points.map((point) => point.longitude).reduce((a, b) => a > b ? a : b);
    return location.latitude >= minLat && location.latitude <= maxLat && location.longitude >= minLng && location.longitude <= maxLng;
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      body: mainProvider.seacrchCo == null
          ? widget.load
              ? Container(color: Colors.white, child: const Center(child: CircularProgressIndicator()))
              : MapLocationPicker(
                  apiKey: "AIzaSyD-zFDSMo3Otg25k6NZ0bMZC2xCPIsof5c",
                  currentLatLng: const package.LatLng(13.0827, 80.2707),
                  hideSuggestionsOnKeyboardHide: true,
                  hideBottomCard: false,
                  hideBackButton: true,
                  bottomCardIcon: const Icon(Icons.done),
                  hideMapTypeButton: true,
                  minMaxZoomPreference: const package.MinMaxZoomPreference(10, 20),
                  onNext: (val) {
                    widget.onPicked(LatLong(val!.geometry.location.lat, val.geometry.location.lng));
                  },
                  hideMoreOptions: true)
          : MapLocationPicker(
              apiKey: "AIzaSyD-zFDSMo3Otg25k6NZ0bMZC2xCPIsof5c",
              currentLatLng: package.LatLng(mainProvider.seacrchCo!.latitude, mainProvider.seacrchCo!.longitude),
              hideSuggestionsOnKeyboardHide: true,
              hideBottomCard: false,
              hideBackButton: true,
              bottomCardIcon: const Icon(Icons.done),
              hideMapTypeButton: true,
              minMaxZoomPreference: const package.MinMaxZoomPreference(10, 20),
              onNext: (val) {
                widget.onPicked(LatLong(val!.geometry.location.lat, val.geometry.location.lng));
                // print(isLocationInsideBorder(package.LatLng(val.geometry.location.lat, val.geometry.location.lng)));
              },
              hideMoreOptions: true),
    );
  }
}

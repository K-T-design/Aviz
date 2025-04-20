import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

MarkerIcon buildMarkerIcon() {
  return const MarkerIcon(
    icon: Icon(
      Icons.location_pin,
      size: 48,
      color: Colors.red,
    ),
  );
}

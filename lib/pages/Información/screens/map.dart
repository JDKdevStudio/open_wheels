import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_wheels/classes/classes.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Routes;

    Set<Polyline> _polylines = <Polyline>{};
    int _polylineIdCounter = 1;

    void _setPolyline(List<PointLatLng> points) {
      final String polylineIdVal = 'polyline_$_polylineIdCounter';
      _polylineIdCounter++;

      _polylines.add(
        Polyline(
            polylineId: PolylineId(polylineIdVal),
            width: 2,
            color: Colors.blue,
            points: points
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList()),
      );
    }

    _setPolyline(PolylinePoints().decodePolyline(args.path!['polyline']));

    Map<String, dynamic> boundsNe = args.path!['bounds_ne'];
    Map<String, dynamic> boundsSw = args.path!['bounds_sw'];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff1C2321),
        ),
        body: GoogleMap(
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
              northeast: LatLng(boundsNe['lat'], boundsNe['lng']))),
          polylines: _polylines,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(target: LatLng(1, 1), zoom: 15),
        ));
  }
}

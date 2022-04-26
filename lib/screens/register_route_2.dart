import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_wheels/search/search_origin.dart';

class RegisterRouteScreen extends StatelessWidget {
  const RegisterRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1C2321),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(),
              ),
              IconButton(
                onPressed: () =>
                    showSearch(context: context, delegate: SearchOrigin()),
                icon: const Icon(Icons.search_outlined),
              )
            ],
          ),
          Expanded(
            child: Stack(children: const [
              GoogleMap(
                myLocationEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(7.068253, -73.108250), zoom: 15),
              ),
              Positioned(
                top: 300,
                child: Icon(Icons.search),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

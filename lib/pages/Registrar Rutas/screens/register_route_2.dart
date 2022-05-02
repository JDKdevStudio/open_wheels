import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_wheels/classes/place_search.dart';
import 'package:open_wheels/search/search_route_point.dart';
import 'package:open_wheels/services/places_service.dart';

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
                onPressed: () async {
                  PlaceSearch result = await showSearch(
                      context: context, delegate: SearchPlacesAddress());
                },
                icon: const Icon(Icons.search_outlined),
              )
            ],
          ),
          Expanded(
            child: Stack(children: [
              const GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(7.068253, -73.108250), zoom: 15),
              ),
              Positioned(
                top: 300,
                child: GestureDetector(
                    child: const Icon(Icons.search),
                    onTap: () {
                      var test = PlacesService();
                      test
                          .getAutocomplete('cacique')
                          .then((value) => value.forEach((element) {
                                print(element.description);
                              }));
                    }),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

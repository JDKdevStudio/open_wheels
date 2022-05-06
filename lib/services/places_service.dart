import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:open_wheels/classes/place_search.dart';
import 'package:open_wheels/helpers/debouncer.dart';

class PlacesService extends ChangeNotifier {
  final _key = 'AIzaSyCe4Rkl4BNJ6t2A9UFmcoCj83_0U0DLyV4';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //get current position to locate accurate places
    final _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode|establishment&language=co&key=$_key&radius=1000&location=${_position.latitude},${_position.longitude}&components=country:co';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((e) => PlaceSearch.fromJson(e)).toList();
  }

//StreamData para el autocompletado
  final StreamController<List<PlaceSearch>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<PlaceSearch>> get suggestionStream =>
      _suggestionStreamController.stream;

  //Debouncer para la búsqueda de autocompletado
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await getAutocomplete(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }

  //get route points
  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    String originPlace = 'place_id:' + origin;
    String destinationPlace = 'place_id:' + destination;
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$originPlace&destination=$destinationPlace&key=$_key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points']
    };
    return results;
  }
}

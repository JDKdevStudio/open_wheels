import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/services/places_service.dart';
import 'package:provider/provider.dart';

class SearchPlacesAddress extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar dirección';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, []);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final placesProvider = Provider.of<PlacesService>(context, listen: false);
    placesProvider.getSuggestionsByQuery(query);
    return StreamBuilder(
      stream: placesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<PlaceSearch>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final places = snapshot.data!;

        return ListView.separated(
            separatorBuilder: ((_, __) => const Divider()),
            itemCount: places.length,
            itemBuilder: (context, int index) {
              var placeSearch = places[index];
              return ListTile(
                title: Text(placeSearch.description!),
                onTap: () {
                  close(
                      context, [placeSearch.description, placeSearch.placeId]);
                },
              );
            });
      },
    );
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(
        Icons.map_outlined,
        color: Colors.black38,
        size: 130,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final placesProvider = Provider.of<PlacesService>(context, listen: false);
    placesProvider.getSuggestionsByQuery(query);
    return StreamBuilder(
      stream: placesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<PlaceSearch>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final places = snapshot.data!;

        return ListView.separated(
            separatorBuilder: ((_, __) => const Divider()),
            itemCount: places.length,
            itemBuilder: (context, int index) {
              var placeSearch = places[index];
              return ListTile(
                title: Text(placeSearch.description!),
                onTap: () {
                  close(
                      context, [placeSearch.description, placeSearch.placeId]);
                },
              );
            });
      },
    );
  }
}

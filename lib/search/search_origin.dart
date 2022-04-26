import 'package:flutter/material.dart';

class SearchOrigin extends SearchDelegate {
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
        icon: const Icon( Icons.arrow_back ),
        onPressed: () {
          close(context, null );
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
  return const Text('buildResults');
  }

   Widget _emptyContainer() {
      return const Center(
        child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 130, ),
      );
    }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _emptyContainer();
  }
}

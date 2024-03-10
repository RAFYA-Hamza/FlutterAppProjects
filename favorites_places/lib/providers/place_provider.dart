import 'package:favorites_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceProvider extends StateNotifier<List<Place>> {
  PlaceProvider() : super([]);

  void addPlace(Place place) {
    state = [...state, place];
  }
}

final addPlaceProvider = StateNotifierProvider<PlaceProvider, List<Place>>(
  (ref) {
    return PlaceProvider();
  },
);

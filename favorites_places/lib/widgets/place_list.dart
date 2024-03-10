import 'package:favorites_places/model/place.dart';
import 'package:favorites_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.placesList});
  final List<Place> placesList;

  @override
  Widget build(BuildContext context) {
    return placesList.isEmpty
        ? Center(
            child: Text(
              'No place add yet!',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          )
        : ListView.builder(
            itemCount: placesList.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: cir,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PlaceDetailsScreen(
                          place: placesList[index],
                        );
                      },
                    ),
                  );
                },
                title: Text(
                  placesList[index].title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              );
            },
          );
  }
}

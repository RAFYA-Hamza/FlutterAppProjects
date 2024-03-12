import 'package:favorites_places/model/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;

  bool _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
      final double lat;
      final double lng;
      lat = locationData.latitude!;
      lng = locationData.longitude!;
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: 'default address',
      );
    });

    setState(() {
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_pickedLocation?.latitude != null ||
        _pickedLocation?.longitude != null) {
      previewContent = FlutterMap(
        options: MapOptions(
          initialCenter: lat_lng.LatLng(
            _pickedLocation!.latitude!,
            _pickedLocation!.longitude!,
          ),
          initialZoom: 1,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/hrafya/clhopjys001ta01pg0oi8blwj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaHJhZnlhIiwiYSI6ImNsaG9tY29yMDF4NjkzY254a2J4dzkxaDQifQ.pwEMVKWZFaD7llK40Z0bFA',
            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1IjoiaHJhZnlhIiwiYSI6ImNsaG9tY29yMDF4NjkzY254a2J4dzkxaDQifQ.pwEMVKWZFaD7llK40Z0bFA',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: lat_lng.LatLng(
                    _pickedLocation!.latitude!, _pickedLocation!.longitude!),
                child: const Icon(Icons.location_on),
              ),
            ],
          ),
        ],
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}

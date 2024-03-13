import 'package:favorites_places/model/place.dart';
import 'package:favorites_places/screens/map.dart';
import 'package:favorites_places/widgets/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSelectedPlace,
  });

  final void Function(PlaceLocation location) onSelectedPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  String address = '';

  bool _isGettingLocation = false;

  void _getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final double lat;
    final double lng;

    lat = locationData.latitude!;
    lng = locationData.longitude!;

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];

    address = '${place.street}, ${place.locality}, ${place.country}';
    _savedLocation(
      PlaceLocation(latitude: lat, longitude: lng, address: address),
    );
  }

  void _savedLocation(PlaceLocation location) {
    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.address,
      );

      widget.onSelectedPlace(_pickedLocation!);

      _isGettingLocation = false;
    });
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<PlaceLocation>(
      MaterialPageRoute(
        builder: (context) {
          return MapScreen();
        },
      ),
    );

    setState(() {
      _isGettingLocation = true;
    });

    if (pickedLocation == null) {
      return;
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          pickedLocation.latitude!, pickedLocation.longitude!);
      Placemark place = placemarks[0];

      address = '${place.street}, ${place.locality}, ${place.country}';
    } catch (e) {
      _showErrorMessage(context);
    }

    _savedLocation(
      PlaceLocation(
          latitude: pickedLocation.latitude,
          longitude: pickedLocation.longitude,
          address: address),
    );
  }

  void _showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            'Error Determining Address',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          content: Text(
            'Please zoom in on the map to obtain the exact address.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Keep it.'),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              onPressed: () {
                _selectOnMap();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Try again!',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        );
      },
    );
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
      previewContent = FlutterMapWidget(
        location: _pickedLocation,
        isSelecting: false,
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
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}

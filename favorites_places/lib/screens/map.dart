import 'package:favorites_places/model/place.dart';
import 'package:favorites_places/widgets/flutter_map.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 33.955825,
      longitude: -6.879443,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation? location;

  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick Your Location' : 'Your Location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: FlutterMapWidget(
        location: widget.location,
        isSelecting: widget.isSelecting,
        onPickedLocation: (pickedLocation) {
          setState(() {
            _pickedLocation = pickedLocation;
          });
        },
      ),
    );
  }
}

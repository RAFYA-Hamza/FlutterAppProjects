import 'package:favorites_places/model/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({
    super.key,
    required this.location,
    this.isSelecting = true,
    this.onPickedLocation,
  });

  final PlaceLocation? location;
  final bool isSelecting;
  final void Function(PlaceLocation location)? onPickedLocation;

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  LatLng? _pickedLocation;
  bool _errorOccurred = false;

  @override
  Widget build(BuildContext context) {
    return _errorOccurred
        ? const Center(
            child: Text('Failed to load map tiles. Please try again.'),
          )
        : FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                widget.location!.latitude!,
                widget.location!.longitude!,
              ),
              initialZoom: 12,
              onTap: (tapPosition, point) {
                setState(() {
                  _pickedLocation = point;
                  widget.onPickedLocation!(
                    PlaceLocation(
                        latitude: point.latitude,
                        longitude: point.longitude,
                        address: ''),
                  );
                });
              },
            ),
            children: [
              TileLayer(
                errorTileCallback: (tile, error, stackTrace) {
                  setState(() {
                    _errorOccurred = true;
                  });
                },
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
                  if (_pickedLocation != null || widget.isSelecting == false)
                    Marker(
                      point: _pickedLocation ??
                          LatLng(
                            widget.location!.latitude!,
                            widget.location!.longitude!,
                          ),
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          );
  }
}

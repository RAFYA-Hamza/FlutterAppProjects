import 'dart:io';

import 'package:favorites_places/model/place.dart';
import 'package:favorites_places/providers/place_provider.dart';
import 'package:favorites_places/widgets/image_input.dart';
import 'package:favorites_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  String? errorTextEntred;
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final entredTitle = _titleController.text;

    if (_selectedImage == null) {
      if (entredTitle.isEmpty) {
        setState(() {
          errorTextEntred = "This field cannot be empty.";
        });
        return;
      }
      return;
    }

    ref.read(addPlaceProvider.notifier).addPlace(
          Place(
            image: _selectedImage!,
            title: entredTitle,
            location: _selectedLocation!,
          ),
        );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new Place',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                errorText: errorTextEntred,
                label: const Text('Title'),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 16),
            LocationInput(
              onSelectedPlace: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _savePlace(),
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                'Add Place',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

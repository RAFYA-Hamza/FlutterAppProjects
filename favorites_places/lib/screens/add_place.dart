import 'package:favorites_places/model/place.dart';
import 'package:favorites_places/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
          ),
          TextButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
              Colors.black87,
            )),
            onPressed: () {
              ref.read(addPlaceProvider.notifier).setPlace(
                    Place(
                      title: controller.text,
                    ),
                  );
              Navigator.pop(context);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                ),
                SizedBox(width: 10),
                Text(
                  'Add Place',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
 Row(
      children: [
        Icon(
        Icons.add,
            ),
                  SizedBox(width: 10),
                  Text(
                    'Add Place',
                  ),
                ],
    ),
*/
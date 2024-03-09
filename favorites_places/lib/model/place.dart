import 'package:uuid/uuid.dart';

class Place {
  Place({
    String? id,
    required this.title,
  }) : id = id ?? const Uuid().v4();

  final String title;
  final String id;
}

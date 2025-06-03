class Player {
  final String id;
  final String firstName;
  final String lastName;
  final List<String> positions;
  final String image;

  Player({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.positions,
    required this.image,
  });

  // It's good practice to override equals and hashCode for data classes.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          // Compare lists by content
          _listEquals(positions, other.positions) &&
          image == other.image;

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      positions.fold(0, (prev, item) => prev ^ item.hashCode) ^ // Combine hash codes of list elements
      image.hashCode;

  // Helper function to compare lists (requires import 'package:flutter/foundation.dart';)
  // However, to keep this model pure Dart, we can implement a simple list comparison.
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}

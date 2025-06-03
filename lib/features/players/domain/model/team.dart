import 'player.dart';

class Team {
  final List<Player> players;
  final int maxPlayers;

  Team({
    List<Player>? players,
    this.maxPlayers = 11,
  }) : this.players = players ?? [];

  bool get isFull => players.length >= maxPlayers;

  Team addPlayer(Player player) {
    if (!isFull && !players.any((p) => p.id == player.id)) {
      return Team(players: [...players, player], maxPlayers: maxPlayers);
    }
    return this; // Or throw an exception/handle error
  }

  Team removePlayer(String playerId) {
    return Team(
        players: players.where((p) => p.id != playerId).toList(),
        maxPlayers: maxPlayers);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          maxPlayers == other.maxPlayers &&
          _listEquals(players, other.players);

  @override
  int get hashCode =>
      players.fold(0, (prev, item) => prev ^ item.hashCode) ^
      maxPlayers.hashCode;

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

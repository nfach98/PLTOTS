import 'package:flutter/material.dart';
import '../../domain/model/player.dart';
import 'player_list_item.dart';

class PlayerListView extends StatelessWidget {
  final List<Player> players;

  const PlayerListView({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return const Center(child: Text('No players available.'));
    }

    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return PlayerListItem(player: player);
      },
    );
  }
}

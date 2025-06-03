import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../../domain/model/player.dart';

class TeamOverviewWidget extends StatelessWidget {
  const TeamOverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Consumer to rebuild when selectedPlayers changes
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        final selectedPlayers = playerProvider.selectedPlayers;
        final teamIsFull = selectedPlayers.length >= 11;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected Team (${selectedPlayers.length}/11)',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  if (selectedPlayers.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        playerProvider.clearTeamSelection();
                      },
                      child: Text('Clear All'),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    )
                ],
              ),
              if (teamIsFull)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('Team is full!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 8.0),
              if (selectedPlayers.isEmpty)
                const Text('No players selected yet. Tap on a player to add them to your team.'),
              if (selectedPlayers.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: selectedPlayers.map((player) {
                    return Chip(
                      // avatar: player.image.isNotEmpty
                      //   ? CircleAvatar(backgroundImage: NetworkImage(player.image), onBackgroundImageError: (e,s) => Icon(Icons.person))
                      //   : null,
                      label: Text('${player.firstName} ${player.lastName}'),
                      onDeleted: () {
                        playerProvider.removePlayer(player.id);
                      },
                      deleteIcon: Icon(Icons.cancel, size: 18),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}

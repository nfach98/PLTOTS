import 'package:flutter/material.dart';
import '../../domain/model/player.dart';
import '../providers/player_provider.dart'; // To access isPlayerSelected and selection logic
import 'package:provider/provider.dart'; // For Provider.of

class PlayerListItem extends StatelessWidget {
  final Player player;

  const PlayerListItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    // Use a Consumer or Selector if you need the widget to rebuild when isPlayerSelected changes for THIS player.
    // For simplicity here, we rely on the parent list to rebuild.
    final bool isSelected = playerProvider.isPlayerSelected(player.id);
    final bool teamIsFull =
        playerProvider.selectedPlayers.length >= 11 && !isSelected;

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        // leading: player.image.isNotEmpty
        //     ? Image.network(player.image, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.person))
        //     : Icon(Icons.person, size: 50), // Placeholder if no image
        title: Text('${player.firstName} ${player.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(player.positions.join(', ')),
        trailing: Icon(
          isSelected ? Icons.check_circle : Icons.add_circle_outline,
          color: isSelected
              ? Colors.green
              : (teamIsFull ? Colors.grey : Colors.blue),
        ),
        onTap: teamIsFull && !isSelected
            ? null
            : () {
                // Disable tap if team is full and player not already selected
                playerProvider.selectPlayer(player
                    .id); // selectPlayer handles both selection and deselection
              },
      ),
    );
  }
}

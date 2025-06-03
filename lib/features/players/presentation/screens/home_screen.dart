import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../widgets/player_list_view.dart';
import '../widgets/team_overview_widget.dart';
// import '../../domain/model/player.dart'; // No longer needed for _getSamplePlayers

class HomeScreen extends StatelessWidget { // Changed to StatelessWidget
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Consumer<PlayerProvider>(
        builder: (context, playerProvider, child) {
          if (playerProvider.isLoading &&
              playerProvider.availablePlayers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (playerProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${playerProvider.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
                      // Assuming prepopulation is a one-time setup in main.dart
                      playerProvider.fetchPlayers();
                      playerProvider.fetchSelectedPlayers();
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          return Column(
            children: [
              const TeamOverviewWidget(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Available Players',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: PlayerListView(players: playerProvider.availablePlayers),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../widgets/player_list_view.dart';
import '../widgets/team_overview_widget.dart';
import '../../domain/model/player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to interact with Provider safely in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialLoad();
    });
  }

  Future<void> _initialLoad() async {
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    // Prepopulate data (if not already done)
    // In a real app, this data might come from a config or an API
    await playerProvider.prepopulateInitialPlayers(_getSamplePlayers());
    // Fetch all players and selected players
    // The provider methods already handle streams, so they will update the UI
    playerProvider.fetchPlayers();
    playerProvider.fetchSelectedPlayers();
  }

  // Placeholder for sample player data
  // In a real app, this would come from a config, asset, or remote source
  List<Player> _getSamplePlayers() {
    return [
      Player(
          id: "1",
          firstName: "Kevin",
          lastName: "De Bruyne",
          positions: ["CM", "AM"],
          image: "kevin_de_bruyne.png"),
      Player(
          id: "2",
          firstName: "Erling",
          lastName: "Haaland",
          positions: ["ST"],
          image: "erling_haaland.png"),
      Player(
          id: "3",
          firstName: "Mohamed",
          lastName: "Salah",
          positions: ["RW", "ST"],
          image: "mohamed_salah.png"),
      Player(
          id: "4",
          firstName: "Virgil",
          lastName: "van Dijk",
          positions: ["CB"],
          image: "virgil_van_dijk.png"),
      Player(
          id: "5",
          firstName: "Lionel",
          lastName: "Messi",
          positions: ["RW", "AM", "ST"],
          image: "lionel_messi.png"),
      Player(
          id: "6",
          firstName: "Cristiano",
          lastName: "Ronaldo",
          positions: ["ST", "LW"],
          image: "cristiano_ronaldo.png"),
      Player(
          id: "7",
          firstName: "Kylian",
          lastName: "Mbappé",
          positions: ["ST", "LW", "RW"],
          image: "kylian_mbappe.png"),
      Player(
          id: "8",
          firstName: "Neymar",
          lastName: "Jr",
          positions: ["LW", "AM"],
          image: "neymar_jr.png"),
      Player(
          id: "9",
          firstName: "Robert",
          lastName: "Lewandowski",
          positions: ["ST"],
          image: "robert_lewandowski.png"),
      Player(
          id: "10",
          firstName: "Luka",
          lastName: "Modrić",
          positions: ["CM"],
          image: "luka_modric.png"),
      Player(
          id: "11",
          firstName: "Sadio",
          lastName: "Mané",
          positions: ["LW", "ST"],
          image: "sadio_mane.png"),
      Player(
          id: "12",
          firstName: "Alisson",
          lastName: "Becker",
          positions: ["GK"],
          image: "alisson_becker.png"),
      Player(
          id: "13",
          firstName: "Trent",
          lastName: "Alexander-Arnold",
          positions: ["RB"],
          image: "trent_alexander_arnold.png"),
      Player(
          id: "14",
          firstName: "Joshua",
          lastName: "Kimmich",
          positions: ["RB", "DM", "CM"],
          image: "joshua_kimmich.png"),
      Player(
          id: "15",
          firstName: "Karim",
          lastName: "Benzema",
          positions: ["ST"],
          image: "karim_benzema.png"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Team Selector'),
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
                    onPressed: _initialLoad, // Retry loading
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

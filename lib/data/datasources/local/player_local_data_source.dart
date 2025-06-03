import '../../../../domain/model/player.dart'; // Domain player
import 'app_database.dart'; // Drift's PlayerData

abstract class PlayerLocalDataSource {
  Stream<List<Player>> getPlayers();
  Future<void> addPlayer(Player player);
  Future<void> addPlayers(List<Player> players);
  Stream<List<Player>> getSelectedPlayers();
  Future<void> selectPlayer(String playerId);
  Future<void> removePlayerFromSelection(String playerId);
  Future<void> clearSelection();
  Future<void> prePopulatePlayers(List<Player> initialPlayers);
}

// Implementation of PlayerLocalDataSource
class PlayerLocalDataSourceImpl implements PlayerLocalDataSource {
  final AppDatabase database;

  PlayerLocalDataSourceImpl({required this.database});

  // Helper to convert domain Player to Drift's PlayerData
  PlayerData _domainToDriftPlayer(Player player) {
    return PlayerData(
      id: player.id,
      firstName: player.firstName,
      lastName: player.lastName,
      positions: player.positions, // Assumes PositionListConverter handles this
      image: player.image,
    );
  }

  // Helper to convert Drift's PlayerData to domain Player
  Player _driftToDomainPlayer(PlayerData playerData) {
    return Player(
      id: playerData.id,
      firstName: playerData.firstName,
      lastName: playerData.lastName,
      positions: playerData.positions, // Assumes PositionListConverter handles this
      image: playerData.image,
    );
  }

  @override
  Stream<List<Player>> getPlayers() {
    return database.watchAllPlayers().map((driftPlayers) =>
      driftPlayers.map(_driftToDomainPlayer).toList()
    );
  }

  @override
  Future<void> addPlayer(Player player) async {
    await database.insertPlayer(_domainToDriftPlayer(player));
  }

  @override
  Future<void> addPlayers(List<Player> players) async {
    final driftPlayers = players.map(_domainToDriftPlayer).toList();
    await database.insertPlayers(driftPlayers);
  }

  @override
  Future<void> prePopulatePlayers(List<Player> initialPlayers) async {
    final currentPlayers = await database.getAllPlayers();
    if (currentPlayers.isEmpty) {
      final driftPlayers = initialPlayers.map(_domainToDriftPlayer).toList();
      await database.insertPlayers(driftPlayers);
      print("Pre-populated players into the database.");
    } else {
      print("Database already contains players. Skipping pre-population.");
    }
  }

  @override
  Stream<List<Player>> getSelectedPlayers() {
    return database.watchFullSelectedPlayerDetails().map((driftPlayers) =>
      driftPlayers.map(_driftToDomainPlayer).toList()
    );
  }

  @override
  Future<void> selectPlayer(String playerId) async {
    await database.selectPlayer(playerId);
  }

  @override
  Future<void> removePlayerFromSelection(String playerId) async {
    await database.removePlayerFromSelection(playerId);
  }

  @override
  Future<void> clearSelection() async {
    await database.clearSelection();
  }
}

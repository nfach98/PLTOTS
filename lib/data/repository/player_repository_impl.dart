import '../../domain/model/player.dart';
import '../../domain/repository/player_repository.dart';
import '../datasources/local/player_local_data_source.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerLocalDataSource localDataSource;

  PlayerRepositoryImpl({required this.localDataSource});

  @override
  Stream<List<Player>> getPlayers() {
    return localDataSource.getPlayers();
  }

  @override
  Future<void> addPlayer(Player player) {
    return localDataSource.addPlayer(player);
  }

  @override
  Future<void> addPlayers(List<Player> players) {
    return localDataSource.addPlayers(players);
  }

  @override
  Future<void> prePopulatePlayersIfEmpty(List<Player> initialPlayers) {
    return localDataSource.prePopulatePlayers(initialPlayers);
  }

  @override
  Stream<List<Player>> getSelectedPlayers() {
    return localDataSource.getSelectedPlayers();
  }

  @override
  Future<void> selectPlayer(String playerId) {
    return localDataSource.selectPlayer(playerId);
  }

  @override
  Future<void> removePlayerFromSelection(String playerId) {
    return localDataSource.removePlayerFromSelection(playerId);
  }

  @override
  Future<void> clearSelection() {
    return localDataSource.clearSelection();
  }
}

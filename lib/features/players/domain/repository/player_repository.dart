import '../model/player.dart';

abstract class PlayerRepository {
  Stream<List<Player>> getPlayers();
  Future<void> addPlayer(Player player); // For potential admin/testing use
  Future<void> addPlayers(List<Player> players); // For initial data population
  Stream<List<Player>> getSelectedPlayers();
  Future<void> selectPlayer(String playerId);
  Future<void> removePlayerFromSelection(String playerId);
  Future<void> clearSelection();
  Future<void> prePopulatePlayersIfEmpty(List<Player> initialPlayers);
}

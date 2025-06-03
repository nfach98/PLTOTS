import '../repository/player_repository.dart';

class RemovePlayerFromSelectionUseCase {
  final PlayerRepository repository;

  RemovePlayerFromSelectionUseCase(this.repository);

  Future<void> call(String playerId) {
    return repository.removePlayerFromSelection(playerId);
  }
}

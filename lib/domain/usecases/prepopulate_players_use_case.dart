import '../model/player.dart';
import '../repository/player_repository.dart';

class PrepopulatePlayersUseCase {
  final PlayerRepository repository;

  PrepopulatePlayersUseCase(this.repository);

  Future<void> call(List<Player> initialPlayers) {
    return repository.prePopulatePlayersIfEmpty(initialPlayers);
  }
}

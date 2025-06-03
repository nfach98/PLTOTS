import '../model/player.dart';
import '../repository/player_repository.dart';

class GetPlayersUseCase {
  final PlayerRepository repository;

  GetPlayersUseCase(this.repository);

  Stream<List<Player>> call() {
    return repository.getPlayers();
  }
}

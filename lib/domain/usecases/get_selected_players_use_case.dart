import '../model/player.dart';
import '../repository/player_repository.dart';

class GetSelectedPlayersUseCase {
  final PlayerRepository repository;

  GetSelectedPlayersUseCase(this.repository);

  Stream<List<Player>> call() {
    return repository.getSelectedPlayers();
  }
}

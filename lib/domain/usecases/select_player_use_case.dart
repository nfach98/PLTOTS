import '../repository/player_repository.dart';

class SelectPlayerUseCase {
  final PlayerRepository repository;

  SelectPlayerUseCase(this.repository);

  Future<void> call(String playerId) {
    return repository.selectPlayer(playerId);
  }
}

import '../repository/player_repository.dart';

class ClearSelectionUseCase {
  final PlayerRepository repository;

  ClearSelectionUseCase(this.repository);

  Future<void> call() {
    return repository.clearSelection();
  }
}

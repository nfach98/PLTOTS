import 'package:flutter/foundation.dart';
import '../../domain/model/player.dart';
import '../../domain/usecases/get_players_use_case.dart';
import '../../domain/usecases/get_selected_players_use_case.dart';
import '../../domain/usecases/select_player_use_case.dart';
import '../../domain/usecases/remove_player_from_selection_use_case.dart';
import '../../domain/usecases/clear_selection_use_case.dart';
import '../../domain/usecases/prepopulate_players_use_case.dart';

class PlayerProvider with ChangeNotifier {
  final GetPlayersUseCase _getPlayersUseCase;
  final GetSelectedPlayersUseCase _getSelectedPlayersUseCase;
  final SelectPlayerUseCase _selectPlayerUseCase;
  final RemovePlayerFromSelectionUseCase _removePlayerFromSelectionUseCase;
  final ClearSelectionUseCase _clearSelectionUseCase;
  final PrepopulatePlayersUseCase _prepopulatePlayersUseCase;

  PlayerProvider({
    required GetPlayersUseCase getPlayersUseCase,
    required GetSelectedPlayersUseCase getSelectedPlayersUseCase,
    required SelectPlayerUseCase selectPlayerUseCase,
    required RemovePlayerFromSelectionUseCase removePlayerFromSelectionUseCase,
    required ClearSelectionUseCase clearSelectionUseCase,
    required PrepopulatePlayersUseCase prepopulatePlayersUseCase,
  })  : _getPlayersUseCase = getPlayersUseCase,
        _getSelectedPlayersUseCase = getSelectedPlayersUseCase,
        _selectPlayerUseCase = selectPlayerUseCase,
        _removePlayerFromSelectionUseCase = removePlayerFromSelectionUseCase,
        _clearSelectionUseCase = clearSelectionUseCase,
        _prepopulatePlayersUseCase = prepopulatePlayersUseCase {
    // Initial data load can be triggered here if needed, or from UI
  }

  List<Player> _availablePlayers = [];
  List<Player> get availablePlayers => _availablePlayers;

  List<Player> _selectedPlayers = [];
  List<Player> get selectedPlayers => _selectedPlayers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? errorMessage) {
    _error = errorMessage;
    notifyListeners();
  }

  Future<void> fetchPlayers() async {
    _setLoading(true);
    _setError(null);
    try {
      _getPlayersUseCase().listen((players) {
        _availablePlayers = players;
        _setLoading(
            false); // Potentially set loading false earlier if stream is long-lived
        notifyListeners();
      }, onError: (e) {
        _setError(e.toString());
        _setLoading(false);
      });
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  Future<void> fetchSelectedPlayers() async {
    // Selected players are also streamed, similar to available players
    // This ensures UI updates reactively
    _setLoading(true); // Or a specific loading state for selected players
    _setError(null);
    try {
      _getSelectedPlayersUseCase().listen((players) {
        _selectedPlayers = players;
        notifyListeners(); // Make sure to notify after updating selected players
        // Potentially set loading false if this was an initial fetch
      }, onError: (e) {
        _setError(e.toString()); // Handle error specific to selected players
      });
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> selectPlayer(String playerId) async {
    // No loading state change here as it's a quick operation,
    // and UI will update via the stream from fetchSelectedPlayers.
    _setError(null);
    try {
      // Check if player is already selected or if team is full
      if (_selectedPlayers.any((p) => p.id == playerId)) {
        // Already selected, maybe remove them (toggle behavior) or do nothing
        await _removePlayerFromSelectionUseCase(playerId);
      } else if (_selectedPlayers.length < 11) {
        await _selectPlayerUseCase(playerId);
      } else {
        _setError("Team is full (11 players selected).");
        // Optionally notifyListeners if you want to show this error immediately
        // without waiting for a stream update.
      }
      // The streams from fetchPlayers and fetchSelectedPlayers should automatically update the UI.
      // However, sometimes a manual notifyListeners() call might be needed if the state change
      // isn't immediately reflected by stream updates for other parts of the UI.
      notifyListeners(); // To reflect potential error messages or immediate state change
    } catch (e) {
      _setError(e.toString());
      notifyListeners();
    }
  }

  Future<void> removePlayer(String playerId) async {
    _setError(null);
    try {
      await _removePlayerFromSelectionUseCase(playerId);
      // Streams will update the lists.
      notifyListeners(); // For immediate feedback if needed
    } catch (e) {
      _setError(e.toString());
      notifyListeners();
    }
  }

  Future<void> clearTeamSelection() async {
    _setError(null);
    try {
      await _clearSelectionUseCase();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      notifyListeners();
    }
  }

  Future<void> prepopulateInitialPlayers(List<Player> initialPlayers) async {
    _setLoading(true);
    _setError(null);
    try {
      await _prepopulatePlayersUseCase(initialPlayers);
      // After prepopulating, refresh the players list
      // This might not be strictly necessary if the streams auto-update,
      // but good for ensuring data consistency after a one-off operation.
      // await fetchPlayers(); // Or rely on stream from getPlayersUseCase
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  bool isPlayerSelected(String playerId) {
    return _selectedPlayers.any((player) => player.id == playerId);
  }
}

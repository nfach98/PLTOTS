import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pl_tots/features/players/data/datasources/local/app_database.dart';
import 'package:pl_tots/features/players/data/datasources/local/player_local_data_source.dart';
import 'package:pl_tots/features/players/data/repository/player_repository_impl.dart';
import 'package:pl_tots/features/players/domain/model/player.dart';
import 'package:pl_tots/features/players/domain/repository/player_repository.dart';
import 'package:provider/provider.dart';

import 'package:pl_tots/features/players/domain/usecases/clear_selection_use_case.dart';
import 'package:pl_tots/features/players/domain/usecases/get_players_use_case.dart';
import 'package:pl_tots/features/players/domain/usecases/get_selected_players_use_case.dart';
import 'package:pl_tots/features/players/domain/usecases/prepopulate_players_use_case.dart';
import 'package:pl_tots/features/players/domain/usecases/remove_player_from_selection_use_case.dart';
import 'package:pl_tots/features/players/domain/usecases/select_player_use_case.dart';
import 'package:pl_tots/features/players/presentation/providers/player_provider.dart';

void main() {
  testWidgets(
      'PlayerProvider is accessible in the widget tree and loads initial data',
      (WidgetTester tester) async {
    // 1. Setup an in-memory database for testing
    // Assuming AppDatabase has a constructor or a test factory for in-memory db
    final testDb = AppDatabase();

    // 2. Build our app and trigger a frame.
    // Replicate the MultiProvider setup from main.dart
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<AppDatabase>.value(value: testDb),
          ProxyProvider<AppDatabase, PlayerLocalDataSource>(
            update: (_, database, __) =>
                PlayerLocalDataSourceImpl(database: database),
          ),
          ProxyProvider<PlayerLocalDataSource, PlayerRepository>(
            update: (_, localDataSource, __) =>
                PlayerRepositoryImpl(localDataSource: localDataSource),
          ),
          ProxyProvider<PlayerRepository, GetPlayersUseCase>(
            update: (_, repo, __) => GetPlayersUseCase(repo),
          ),
          ProxyProvider<PlayerRepository, GetSelectedPlayersUseCase>(
            update: (_, repo, __) => GetSelectedPlayersUseCase(repo),
          ),
          ProxyProvider<PlayerRepository, SelectPlayerUseCase>(
            update: (_, repo, __) => SelectPlayerUseCase(repo),
          ),
          ProxyProvider<PlayerRepository, RemovePlayerFromSelectionUseCase>(
            update: (_, repo, __) => RemovePlayerFromSelectionUseCase(repo),
          ),
          ProxyProvider<PlayerRepository, ClearSelectionUseCase>(
            update: (_, repo, __) => ClearSelectionUseCase(repo),
          ),
          ProxyProvider<PlayerRepository, PrepopulatePlayersUseCase>(
            update: (_, repo, __) => PrepopulatePlayersUseCase(repo),
          ),
          ChangeNotifierProvider<PlayerProvider>(
            create: (context) {
              final playerProvider = PlayerProvider(
                getPlayersUseCase:
                    Provider.of<GetPlayersUseCase>(context, listen: false),
                getSelectedPlayersUseCase:
                    Provider.of<GetSelectedPlayersUseCase>(context,
                        listen: false),
                selectPlayerUseCase:
                    Provider.of<SelectPlayerUseCase>(context, listen: false),
                removePlayerFromSelectionUseCase:
                    Provider.of<RemovePlayerFromSelectionUseCase>(context,
                        listen: false),
                clearSelectionUseCase:
                    Provider.of<ClearSelectionUseCase>(context, listen: false),
                prepopulatePlayersUseCase:
                    Provider.of<PrepopulatePlayersUseCase>(context,
                        listen: false),
              );
              final List<Player> initialPlayers = [
                Player(
                    id: 't1',
                    firstName: 'Test',
                    lastName: 'Player1',
                    positions: ['GK'],
                    image: 'img1.png'),
                Player(
                    id: 't2',
                    firstName: 'Test',
                    lastName: 'Player2',
                    positions: ['DF'],
                    image: 'img2.png'),
              ];
              // No await here, let pumpAndSettle handle it
              playerProvider
                  .prepopulateInitialPlayers(initialPlayers)
                  .then((_) => playerProvider.fetchPlayers())
                  .then((_) => playerProvider.fetchSelectedPlayers());
              return playerProvider;
            },
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                // Attempt to access the provider
                final playerProvider =
                    Provider.of<PlayerProvider>(context, listen: false);
                expect(playerProvider, isNotNull,
                    reason: "PlayerProvider should be accessible.");
                // This is a good place for an initial check
                return const Text('Test Home Screen'); // Placeholder widget
              },
            ),
          ),
        ),
      ),
    );

    // pumpAndSettle waits for all animations and microtasks to complete.
    // This is crucial for tests involving Future-based operations like database calls.
    await tester.pumpAndSettle();

    // Perform checks after async operations have likely completed
    final BuildContext context = tester.element(
        find.text('Test Home Screen')); // Find the context of our placeholder
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    expect(playerProvider, isNotNull,
        reason: "PlayerProvider should still be accessible.");
    expect(playerProvider.isLoading, isFalse,
        reason:
            "PlayerProvider should not be in loading state after pumpAndSettle.");
    expect(playerProvider.error, isNull,
        reason:
            "PlayerProvider should not have an error after successful load.");

    // Check if prepopulated players are loaded.
    // The number of players should match those prepopulated if the DB was empty.
    expect(playerProvider.availablePlayers.isNotEmpty, isTrue,
        reason: "Available players should be populated.");
    expect(playerProvider.availablePlayers.length, 2,
        reason: "Should have 2 prepopulated players.");
    expect(
        playerProvider.availablePlayers.any((p) =>
            p.id == 't1' && p.firstName == 'Test' && p.lastName == 'Player1'),
        isTrue,
        reason: "Test Player 1 should be in availablePlayers.");
    expect(
        playerProvider.availablePlayers.any((p) =>
            p.id == 't2' && p.firstName == 'Test' && p.lastName == 'Player2'),
        isTrue,
        reason: "Test Player 2 should be in availablePlayers.");

    // Ensure selected players list is initially empty or as expected
    expect(playerProvider.selectedPlayers.isEmpty, isTrue,
        reason: "Selected players should be initially empty.");

    // Close the test database
    await testDb.close();
  });
}

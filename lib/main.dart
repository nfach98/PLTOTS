import 'package:flutter/material.dart';
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
import 'package:pl_tots/features/players/presentation/routes/app_router.dart';

void main() {
  final appDatabase = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: appDatabase),
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
        ChangeNotifierProvider<PlayerProvider>(create: (context) {
          final playerProvider = PlayerProvider(
            getPlayersUseCase:
                Provider.of<GetPlayersUseCase>(context, listen: false),
            getSelectedPlayersUseCase:
                Provider.of<GetSelectedPlayersUseCase>(context, listen: false),
            selectPlayerUseCase:
                Provider.of<SelectPlayerUseCase>(context, listen: false),
            removePlayerFromSelectionUseCase:
                Provider.of<RemovePlayerFromSelectionUseCase>(context,
                    listen: false),
            clearSelectionUseCase:
                Provider.of<ClearSelectionUseCase>(context, listen: false),
            prepopulatePlayersUseCase:
                Provider.of<PrepopulatePlayersUseCase>(context, listen: false),
          );
          // Define a sample list of players for prepopulation
          final List<Player> initialPlayers = [
            Player(
                id: '1',
                firstName: 'Lionel',
                lastName: 'Messi',
                positions: ['Forward'],
                image: 'https://dummyimage.com/100x100/000/fff&text=LM'),
            Player(
                id: '2',
                firstName: 'Cristiano',
                lastName: 'Ronaldo',
                positions: ['Forward'],
                image: 'https://dummyimage.com/100x100/000/fff&text=CR'),
          ];
          // Call initial data loading methods
          playerProvider
              .prepopulateInitialPlayers(initialPlayers)
              .then((_) => playerProvider.fetchPlayers())
              .then((_) => playerProvider.fetchSelectedPlayers());
          return playerProvider;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

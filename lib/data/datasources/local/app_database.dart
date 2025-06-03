import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Import table definition files
import 'player_table.dart';
import 'selected_player_table.dart';

// Import the generated part file (will be created by build_runner)
part 'app_database.g.dart'; // Ensure this matches the output file name

@DriftDatabase(tables: [Players, SelectedPlayers])
class AppDatabase extends _\$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.test(QueryExecutor e) : super(e); // Constructor for testing

  @override
  int get schemaVersion => 1;

  // Methods for interacting with Players table
  Future<List<PlayerData>> getAllPlayers() => select(players).get();
  Stream<List<PlayerData>> watchAllPlayers() => select(players).watch();
  Future<void> insertPlayer(PlayerData player) => into(players).insert(player, mode: InsertMode.insertOrReplace);
  Future<void> insertPlayers(List<PlayerData> playerList) async {
    await batch((batch) {
      batch.insertAll(players, playerList, mode: InsertMode.insertOrReplace);
    });
  }
  Future<PlayerData?> getPlayerById(String id) => (select(players)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // Methods for interacting with SelectedPlayers table
  Stream<List<SelectedPlayer>> watchSelectedPlayers() => select(selectedPlayers).watch();

  Future<List<PlayerData>> getFullSelectedPlayerDetails() async {
    // Join SelectedPlayers with Players to get full PlayerData
    final query = select(selectedPlayers).join([
      innerJoin(players, players.id.equalsExp(selectedPlayers.playerId))
    ]);

    return query.map((row) => row.readTable(players)).get();
  }

  Stream<List<PlayerData>> watchFullSelectedPlayerDetails() {
    final query = select(selectedPlayers).join([
      innerJoin(players, players.id.equalsExp(selectedPlayers.playerId))
    ]);

    return query.map((row) => row.readTable(players)).watch();
  }

  Future<void> selectPlayer(String playerId) async {
    // Check current count
    final currentSelected = await select(selectedPlayers).get();
    if (currentSelected.length < 11) {
      await into(selectedPlayers).insert(
        SelectedPlayersCompanion.insert(playerId: playerId),
        mode: InsertMode.insertOrIgnore // Ignore if already selected
      );
    } else {
      // Optionally throw an error or handle the "team full" case
      print("Team is full. Cannot select more than 11 players.");
    }
  }

  Future<void> removePlayerFromSelection(String playerId) =>
      (delete(selectedPlayers)..where((tbl) => tbl.playerId.equals(playerId))).go();

  Future<void> clearSelection() => delete(selectedPlayers).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

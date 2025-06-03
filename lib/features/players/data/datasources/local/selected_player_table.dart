import 'package:drift/drift.dart';
import 'player_table.dart';

class SelectedPlayers extends Table {
  TextColumn get playerId => text().references(Players, #id)();
  DateTimeColumn get dateSelected => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {playerId};
}

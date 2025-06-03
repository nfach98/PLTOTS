import 'package:drift/drift.dart';

// TypeConverter for List<String> to store as comma-separated String
class PositionListConverter extends TypeConverter<List<String>, String> {
  const PositionListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}

@DataClassName('PlayerData') // To avoid name clash with domain Player
class Players extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get positions => text().map(const PositionListConverter())();
  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {id};
}

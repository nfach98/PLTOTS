// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, PlayerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionsMeta =
      const VerificationMeta('positions');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> positions =
      GeneratedColumn<String>('positions', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($PlayersTable.$converterpositions);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, firstName, lastName, positions, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(Insertable<PlayerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    context.handle(_positionsMeta, const VerificationResult.success());
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      positions: $PlayersTable.$converterpositions.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}positions'])!),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterpositions =
      const PositionListConverter();
}

class PlayerData extends DataClass implements Insertable<PlayerData> {
  final String id;
  final String firstName;
  final String lastName;
  final List<String> positions;
  final String image;
  const PlayerData(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.positions,
      required this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    {
      map['positions'] =
          Variable<String>($PlayersTable.$converterpositions.toSql(positions));
    }
    map['image'] = Variable<String>(image);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      positions: Value(positions),
      image: Value(image),
    );
  }

  factory PlayerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerData(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      positions: serializer.fromJson<List<String>>(json['positions']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'positions': serializer.toJson<List<String>>(positions),
      'image': serializer.toJson<String>(image),
    };
  }

  PlayerData copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          List<String>? positions,
          String? image}) =>
      PlayerData(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        positions: positions ?? this.positions,
        image: image ?? this.image,
      );
  PlayerData copyWithCompanion(PlayersCompanion data) {
    return PlayerData(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      positions: data.positions.present ? data.positions.value : this.positions,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerData(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('positions: $positions, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, positions, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerData &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.positions == this.positions &&
          other.image == this.image);
}

class PlayersCompanion extends UpdateCompanion<PlayerData> {
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<List<String>> positions;
  final Value<String> image;
  final Value<int> rowid;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.positions = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersCompanion.insert({
    required String id,
    required String firstName,
    required String lastName,
    required List<String> positions,
    required String image,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        firstName = Value(firstName),
        lastName = Value(lastName),
        positions = Value(positions),
        image = Value(image);
  static Insertable<PlayerData> custom({
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? positions,
    Expression<String>? image,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (positions != null) 'positions': positions,
      if (image != null) 'image': image,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<List<String>>? positions,
      Value<String>? image,
      Value<int>? rowid}) {
    return PlayersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      positions: positions ?? this.positions,
      image: image ?? this.image,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (positions.present) {
      map['positions'] = Variable<String>(
          $PlayersTable.$converterpositions.toSql(positions.value));
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('positions: $positions, ')
          ..write('image: $image, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SelectedPlayersTable extends SelectedPlayers
    with TableInfo<$SelectedPlayersTable, SelectedPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SelectedPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES players (id)'));
  static const VerificationMeta _dateSelectedMeta =
      const VerificationMeta('dateSelected');
  @override
  late final GeneratedColumn<DateTime> dateSelected = GeneratedColumn<DateTime>(
      'date_selected', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [playerId, dateSelected];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'selected_players';
  @override
  VerificationContext validateIntegrity(Insertable<SelectedPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('date_selected')) {
      context.handle(
          _dateSelectedMeta,
          dateSelected.isAcceptableOrUnknown(
              data['date_selected']!, _dateSelectedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playerId};
  @override
  SelectedPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SelectedPlayer(
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      dateSelected: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_selected'])!,
    );
  }

  @override
  $SelectedPlayersTable createAlias(String alias) {
    return $SelectedPlayersTable(attachedDatabase, alias);
  }
}

class SelectedPlayer extends DataClass implements Insertable<SelectedPlayer> {
  final String playerId;
  final DateTime dateSelected;
  const SelectedPlayer({required this.playerId, required this.dateSelected});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<String>(playerId);
    map['date_selected'] = Variable<DateTime>(dateSelected);
    return map;
  }

  SelectedPlayersCompanion toCompanion(bool nullToAbsent) {
    return SelectedPlayersCompanion(
      playerId: Value(playerId),
      dateSelected: Value(dateSelected),
    );
  }

  factory SelectedPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SelectedPlayer(
      playerId: serializer.fromJson<String>(json['playerId']),
      dateSelected: serializer.fromJson<DateTime>(json['dateSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playerId': serializer.toJson<String>(playerId),
      'dateSelected': serializer.toJson<DateTime>(dateSelected),
    };
  }

  SelectedPlayer copyWith({String? playerId, DateTime? dateSelected}) =>
      SelectedPlayer(
        playerId: playerId ?? this.playerId,
        dateSelected: dateSelected ?? this.dateSelected,
      );
  SelectedPlayer copyWithCompanion(SelectedPlayersCompanion data) {
    return SelectedPlayer(
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      dateSelected: data.dateSelected.present
          ? data.dateSelected.value
          : this.dateSelected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SelectedPlayer(')
          ..write('playerId: $playerId, ')
          ..write('dateSelected: $dateSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playerId, dateSelected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SelectedPlayer &&
          other.playerId == this.playerId &&
          other.dateSelected == this.dateSelected);
}

class SelectedPlayersCompanion extends UpdateCompanion<SelectedPlayer> {
  final Value<String> playerId;
  final Value<DateTime> dateSelected;
  final Value<int> rowid;
  const SelectedPlayersCompanion({
    this.playerId = const Value.absent(),
    this.dateSelected = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SelectedPlayersCompanion.insert({
    required String playerId,
    this.dateSelected = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : playerId = Value(playerId);
  static Insertable<SelectedPlayer> custom({
    Expression<String>? playerId,
    Expression<DateTime>? dateSelected,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (dateSelected != null) 'date_selected': dateSelected,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SelectedPlayersCompanion copyWith(
      {Value<String>? playerId,
      Value<DateTime>? dateSelected,
      Value<int>? rowid}) {
    return SelectedPlayersCompanion(
      playerId: playerId ?? this.playerId,
      dateSelected: dateSelected ?? this.dateSelected,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (dateSelected.present) {
      map['date_selected'] = Variable<DateTime>(dateSelected.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SelectedPlayersCompanion(')
          ..write('playerId: $playerId, ')
          ..write('dateSelected: $dateSelected, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $SelectedPlayersTable selectedPlayers =
      $SelectedPlayersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [players, selectedPlayers];
}

typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({
  required String id,
  required String firstName,
  required String lastName,
  required List<String> positions,
  required String image,
  Value<int> rowid,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<String> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<List<String>> positions,
  Value<String> image,
  Value<int> rowid,
});

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, PlayerData> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SelectedPlayersTable, List<SelectedPlayer>>
      _selectedPlayersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.selectedPlayers,
              aliasName: $_aliasNameGenerator(
                  db.players.id, db.selectedPlayers.playerId));

  $$SelectedPlayersTableProcessedTableManager get selectedPlayersRefs {
    final manager =
        $$SelectedPlayersTableTableManager($_db, $_db.selectedPlayers)
            .filter((f) => f.playerId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_selectedPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get positions => $composableBuilder(
          column: $table.positions,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  Expression<bool> selectedPlayersRefs(
      Expression<bool> Function($$SelectedPlayersTableFilterComposer f) f) {
    final $$SelectedPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.selectedPlayers,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SelectedPlayersTableFilterComposer(
              $db: $db,
              $table: $db.selectedPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get positions => $composableBuilder(
      column: $table.positions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get positions =>
      $composableBuilder(column: $table.positions, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  Expression<T> selectedPlayersRefs<T extends Object>(
      Expression<T> Function($$SelectedPlayersTableAnnotationComposer a) f) {
    final $$SelectedPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.selectedPlayers,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SelectedPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.selectedPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlayersTable,
    PlayerData,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (PlayerData, $$PlayersTableReferences),
    PlayerData,
    PrefetchHooks Function({bool selectedPlayersRefs})> {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<List<String>> positions = const Value.absent(),
            Value<String> image = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            positions: positions,
            image: image,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String firstName,
            required String lastName,
            required List<String> positions,
            required String image,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            positions: positions,
            image: image,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PlayersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({selectedPlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (selectedPlayersRefs) db.selectedPlayers
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (selectedPlayersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlayersTableReferences
                            ._selectedPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlayersTableReferences(db, table, p0)
                                .selectedPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlayersTable,
    PlayerData,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (PlayerData, $$PlayersTableReferences),
    PlayerData,
    PrefetchHooks Function({bool selectedPlayersRefs})>;
typedef $$SelectedPlayersTableCreateCompanionBuilder = SelectedPlayersCompanion
    Function({
  required String playerId,
  Value<DateTime> dateSelected,
  Value<int> rowid,
});
typedef $$SelectedPlayersTableUpdateCompanionBuilder = SelectedPlayersCompanion
    Function({
  Value<String> playerId,
  Value<DateTime> dateSelected,
  Value<int> rowid,
});

final class $$SelectedPlayersTableReferences extends BaseReferences<
    _$AppDatabase, $SelectedPlayersTable, SelectedPlayer> {
  $$SelectedPlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
          $_aliasNameGenerator(db.selectedPlayers.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.id($_item.playerId));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SelectedPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $SelectedPlayersTable> {
  $$SelectedPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get dateSelected => $composableBuilder(
      column: $table.dateSelected, builder: (column) => ColumnFilters(column));

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SelectedPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $SelectedPlayersTable> {
  $$SelectedPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get dateSelected => $composableBuilder(
      column: $table.dateSelected,
      builder: (column) => ColumnOrderings(column));

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SelectedPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SelectedPlayersTable> {
  $$SelectedPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get dateSelected => $composableBuilder(
      column: $table.dateSelected, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SelectedPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SelectedPlayersTable,
    SelectedPlayer,
    $$SelectedPlayersTableFilterComposer,
    $$SelectedPlayersTableOrderingComposer,
    $$SelectedPlayersTableAnnotationComposer,
    $$SelectedPlayersTableCreateCompanionBuilder,
    $$SelectedPlayersTableUpdateCompanionBuilder,
    (SelectedPlayer, $$SelectedPlayersTableReferences),
    SelectedPlayer,
    PrefetchHooks Function({bool playerId})> {
  $$SelectedPlayersTableTableManager(
      _$AppDatabase db, $SelectedPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SelectedPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SelectedPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SelectedPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> playerId = const Value.absent(),
            Value<DateTime> dateSelected = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SelectedPlayersCompanion(
            playerId: playerId,
            dateSelected: dateSelected,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String playerId,
            Value<DateTime> dateSelected = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SelectedPlayersCompanion.insert(
            playerId: playerId,
            dateSelected: dateSelected,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SelectedPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable:
                        $$SelectedPlayersTableReferences._playerIdTable(db),
                    referencedColumn:
                        $$SelectedPlayersTableReferences._playerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SelectedPlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SelectedPlayersTable,
    SelectedPlayer,
    $$SelectedPlayersTableFilterComposer,
    $$SelectedPlayersTableOrderingComposer,
    $$SelectedPlayersTableAnnotationComposer,
    $$SelectedPlayersTableCreateCompanionBuilder,
    $$SelectedPlayersTableUpdateCompanionBuilder,
    (SelectedPlayer, $$SelectedPlayersTableReferences),
    SelectedPlayer,
    PrefetchHooks Function({bool playerId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$SelectedPlayersTableTableManager get selectedPlayers =>
      $$SelectedPlayersTableTableManager(_db, _db.selectedPlayers);
}

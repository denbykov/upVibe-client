// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ServerConnectionsTable extends ServerConnections
    with TableInfo<$ServerConnectionsTable, ServerConnection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerConnectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _hostMeta = const VerificationMeta('host');
  @override
  late final GeneratedColumn<String> host = GeneratedColumn<String>(
      'host', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portMeta = const VerificationMeta('port');
  @override
  late final GeneratedColumn<int> port = GeneratedColumn<int>(
      'port', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [host, port];
  @override
  String get aliasedName => _alias ?? 'server_connections';
  @override
  String get actualTableName => 'server_connections';
  @override
  VerificationContext validateIntegrity(Insertable<ServerConnection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('host')) {
      context.handle(
          _hostMeta, host.isAcceptableOrUnknown(data['host']!, _hostMeta));
    } else if (isInserting) {
      context.missing(_hostMeta);
    }
    if (data.containsKey('port')) {
      context.handle(
          _portMeta, port.isAcceptableOrUnknown(data['port']!, _portMeta));
    } else if (isInserting) {
      context.missing(_portMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ServerConnection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerConnection(
      host: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}host'])!,
      port: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}port'])!,
    );
  }

  @override
  $ServerConnectionsTable createAlias(String alias) {
    return $ServerConnectionsTable(attachedDatabase, alias);
  }
}

class ServerConnection extends DataClass
    implements Insertable<ServerConnection> {
  final String host;
  final int port;
  const ServerConnection({required this.host, required this.port});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['host'] = Variable<String>(host);
    map['port'] = Variable<int>(port);
    return map;
  }

  ServerConnectionsCompanion toCompanion(bool nullToAbsent) {
    return ServerConnectionsCompanion(
      host: Value(host),
      port: Value(port),
    );
  }

  factory ServerConnection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerConnection(
      host: serializer.fromJson<String>(json['host']),
      port: serializer.fromJson<int>(json['port']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'host': serializer.toJson<String>(host),
      'port': serializer.toJson<int>(port),
    };
  }

  ServerConnection copyWith({String? host, int? port}) => ServerConnection(
        host: host ?? this.host,
        port: port ?? this.port,
      );
  @override
  String toString() {
    return (StringBuffer('ServerConnection(')
          ..write('host: $host, ')
          ..write('port: $port')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(host, port);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerConnection &&
          other.host == this.host &&
          other.port == this.port);
}

class ServerConnectionsCompanion extends UpdateCompanion<ServerConnection> {
  final Value<String> host;
  final Value<int> port;
  final Value<int> rowid;
  const ServerConnectionsCompanion({
    this.host = const Value.absent(),
    this.port = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServerConnectionsCompanion.insert({
    required String host,
    required int port,
    this.rowid = const Value.absent(),
  })  : host = Value(host),
        port = Value(port);
  static Insertable<ServerConnection> custom({
    Expression<String>? host,
    Expression<int>? port,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (host != null) 'host': host,
      if (port != null) 'port': port,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServerConnectionsCompanion copyWith(
      {Value<String>? host, Value<int>? port, Value<int>? rowid}) {
    return ServerConnectionsCompanion(
      host: host ?? this.host,
      port: port ?? this.port,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (host.present) {
      map['host'] = Variable<String>(host.value);
    }
    if (port.present) {
      map['port'] = Variable<int>(port.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerConnectionsCompanion(')
          ..write('host: $host, ')
          ..write('port: $port, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuthenticationTable extends Authentication
    with TableInfo<$AuthenticationTable, AuthenticationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthenticationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
      'refresh_token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
      'access_token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [refreshToken, accessToken];
  @override
  String get aliasedName => _alias ?? 'authentication';
  @override
  String get actualTableName => 'authentication';
  @override
  VerificationContext validateIntegrity(Insertable<AuthenticationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('refresh_token')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refresh_token']!, _refreshTokenMeta));
    } else if (isInserting) {
      context.missing(_refreshTokenMeta);
    }
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token']!, _accessTokenMeta));
    } else if (isInserting) {
      context.missing(_accessTokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AuthenticationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthenticationData(
      refreshToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}refresh_token'])!,
      accessToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}access_token'])!,
    );
  }

  @override
  $AuthenticationTable createAlias(String alias) {
    return $AuthenticationTable(attachedDatabase, alias);
  }
}

class AuthenticationData extends DataClass
    implements Insertable<AuthenticationData> {
  final String refreshToken;
  final String accessToken;
  const AuthenticationData(
      {required this.refreshToken, required this.accessToken});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['refresh_token'] = Variable<String>(refreshToken);
    map['access_token'] = Variable<String>(accessToken);
    return map;
  }

  AuthenticationCompanion toCompanion(bool nullToAbsent) {
    return AuthenticationCompanion(
      refreshToken: Value(refreshToken),
      accessToken: Value(accessToken),
    );
  }

  factory AuthenticationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthenticationData(
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      accessToken: serializer.fromJson<String>(json['accessToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'refreshToken': serializer.toJson<String>(refreshToken),
      'accessToken': serializer.toJson<String>(accessToken),
    };
  }

  AuthenticationData copyWith({String? refreshToken, String? accessToken}) =>
      AuthenticationData(
        refreshToken: refreshToken ?? this.refreshToken,
        accessToken: accessToken ?? this.accessToken,
      );
  @override
  String toString() {
    return (StringBuffer('AuthenticationData(')
          ..write('refreshToken: $refreshToken, ')
          ..write('accessToken: $accessToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(refreshToken, accessToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthenticationData &&
          other.refreshToken == this.refreshToken &&
          other.accessToken == this.accessToken);
}

class AuthenticationCompanion extends UpdateCompanion<AuthenticationData> {
  final Value<String> refreshToken;
  final Value<String> accessToken;
  final Value<int> rowid;
  const AuthenticationCompanion({
    this.refreshToken = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthenticationCompanion.insert({
    required String refreshToken,
    required String accessToken,
    this.rowid = const Value.absent(),
  })  : refreshToken = Value(refreshToken),
        accessToken = Value(accessToken);
  static Insertable<AuthenticationData> custom({
    Expression<String>? refreshToken,
    Expression<String>? accessToken,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (accessToken != null) 'access_token': accessToken,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthenticationCompanion copyWith(
      {Value<String>? refreshToken,
      Value<String>? accessToken,
      Value<int>? rowid}) {
    return AuthenticationCompanion(
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthenticationCompanion(')
          ..write('refreshToken: $refreshToken, ')
          ..write('accessToken: $accessToken, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ServerConnectionsTable serverConnections =
      $ServerConnectionsTable(this);
  late final $AuthenticationTable authentication = $AuthenticationTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [serverConnections, authentication];
}

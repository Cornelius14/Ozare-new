// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

History _$HistoryFromJson(Map<String, dynamic> json) {
  return _History.fromJson(json);
}

/// @nodoc
mixin _$History {
  String get id => throw _privateConstructorUsedError;
  String get team1 => throw _privateConstructorUsedError;
  String get team2 => throw _privateConstructorUsedError;
  String get score1 => throw _privateConstructorUsedError;
  String get score2 => throw _privateConstructorUsedError;
  String get logo1 => throw _privateConstructorUsedError;
  String get logo2 => throw _privateConstructorUsedError;

  /// 0: draw, 1: team1, 2: team2
  int get won => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCopyWith<History> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCopyWith<$Res> {
  factory $HistoryCopyWith(History value, $Res Function(History) then) =
      _$HistoryCopyWithImpl<$Res, History>;
  @useResult
  $Res call(
      {String id,
      String team1,
      String team2,
      String score1,
      String score2,
      String logo1,
      String logo2,
      int won});
}

/// @nodoc
class _$HistoryCopyWithImpl<$Res, $Val extends History>
    implements $HistoryCopyWith<$Res> {
  _$HistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? team1 = null,
    Object? team2 = null,
    Object? score1 = null,
    Object? score2 = null,
    Object? logo1 = null,
    Object? logo2 = null,
    Object? won = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as String,
      team2: null == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as String,
      score1: null == score1
          ? _value.score1
          : score1 // ignore: cast_nullable_to_non_nullable
              as String,
      score2: null == score2
          ? _value.score2
          : score2 // ignore: cast_nullable_to_non_nullable
              as String,
      logo1: null == logo1
          ? _value.logo1
          : logo1 // ignore: cast_nullable_to_non_nullable
              as String,
      logo2: null == logo2
          ? _value.logo2
          : logo2 // ignore: cast_nullable_to_non_nullable
              as String,
      won: null == won
          ? _value.won
          : won // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HistoryCopyWith<$Res> implements $HistoryCopyWith<$Res> {
  factory _$$_HistoryCopyWith(
          _$_History value, $Res Function(_$_History) then) =
      __$$_HistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String team1,
      String team2,
      String score1,
      String score2,
      String logo1,
      String logo2,
      int won});
}

/// @nodoc
class __$$_HistoryCopyWithImpl<$Res>
    extends _$HistoryCopyWithImpl<$Res, _$_History>
    implements _$$_HistoryCopyWith<$Res> {
  __$$_HistoryCopyWithImpl(_$_History _value, $Res Function(_$_History) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? team1 = null,
    Object? team2 = null,
    Object? score1 = null,
    Object? score2 = null,
    Object? logo1 = null,
    Object? logo2 = null,
    Object? won = null,
  }) {
    return _then(_$_History(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as String,
      team2: null == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as String,
      score1: null == score1
          ? _value.score1
          : score1 // ignore: cast_nullable_to_non_nullable
              as String,
      score2: null == score2
          ? _value.score2
          : score2 // ignore: cast_nullable_to_non_nullable
              as String,
      logo1: null == logo1
          ? _value.logo1
          : logo1 // ignore: cast_nullable_to_non_nullable
              as String,
      logo2: null == logo2
          ? _value.logo2
          : logo2 // ignore: cast_nullable_to_non_nullable
              as String,
      won: null == won
          ? _value.won
          : won // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_History with DiagnosticableTreeMixin implements _History {
  const _$_History(
      {required this.id,
      required this.team1,
      required this.team2,
      required this.score1,
      required this.score2,
      required this.logo1,
      required this.logo2,
      required this.won});

  factory _$_History.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryFromJson(json);

  @override
  final String id;
  @override
  final String team1;
  @override
  final String team2;
  @override
  final String score1;
  @override
  final String score2;
  @override
  final String logo1;
  @override
  final String logo2;

  /// 0: draw, 1: team1, 2: team2
  @override
  final int won;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'History(id: $id, team1: $team1, team2: $team2, score1: $score1, score2: $score2, logo1: $logo1, logo2: $logo2, won: $won)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'History'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('team1', team1))
      ..add(DiagnosticsProperty('team2', team2))
      ..add(DiagnosticsProperty('score1', score1))
      ..add(DiagnosticsProperty('score2', score2))
      ..add(DiagnosticsProperty('logo1', logo1))
      ..add(DiagnosticsProperty('logo2', logo2))
      ..add(DiagnosticsProperty('won', won));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_History &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.team1, team1) || other.team1 == team1) &&
            (identical(other.team2, team2) || other.team2 == team2) &&
            (identical(other.score1, score1) || other.score1 == score1) &&
            (identical(other.score2, score2) || other.score2 == score2) &&
            (identical(other.logo1, logo1) || other.logo1 == logo1) &&
            (identical(other.logo2, logo2) || other.logo2 == logo2) &&
            (identical(other.won, won) || other.won == won));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, team1, team2, score1, score2, logo1, logo2, won);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      __$$_HistoryCopyWithImpl<_$_History>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryToJson(
      this,
    );
  }
}

abstract class _History implements History {
  const factory _History(
      {required final String id,
      required final String team1,
      required final String team2,
      required final String score1,
      required final String score2,
      required final String logo1,
      required final String logo2,
      required final int won}) = _$_History;

  factory _History.fromJson(Map<String, dynamic> json) = _$_History.fromJson;

  @override
  String get id;
  @override
  String get team1;
  @override
  String get team2;
  @override
  String get score1;
  @override
  String get score2;
  @override
  String get logo1;
  @override
  String get logo2;
  @override

  /// 0: draw, 1: team1, 2: team2
  int get won;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      throw _privateConstructorUsedError;
}

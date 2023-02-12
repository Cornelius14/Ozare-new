import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class History with _$History {
  const factory History({
    required String id,
    required String team1,
    required String team2,
    required String score1,
    required String score2,
    required String logo1,
    required String logo2,

    /// 0: draw, 1: team1, 2: team2
    required int won,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}

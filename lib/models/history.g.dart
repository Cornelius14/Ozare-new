// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      id: json['id'] as String,
      team1: json['team1'] as String,
      team2: json['team2'] as String,
      score1: json['score1'] as String,
      score2: json['score2'] as String,
      logo1: json['logo1'] as String,
      logo2: json['logo2'] as String,
      won: json['won'] as int,
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'id': instance.id,
      'team1': instance.team1,
      'team2': instance.team2,
      'score1': instance.score1,
      'score2': instance.score2,
      'logo1': instance.logo1,
      'logo2': instance.logo2,
      'won': instance.won,
    };

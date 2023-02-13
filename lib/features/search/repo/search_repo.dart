import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ozare/features/search/models/team.dart';
import 'dart:convert';

import 'package:ozare/models/models.dart';

final Map<String, String> header = {
  'X-RapidAPI-Key': '07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2',
  'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
};

class SearchRepo {
  Future<List<Team>> getTeams(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/teams?search=$query'),
        headers: header,
      );

      List<Team> parsedTeams = [];

      log('Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseMap = jsonDecode(response.body) as Map<String, dynamic>;
        final responses = responseMap['response'];

        log('results: ${responses.length.toString()}');

        // extract leagues
        for (final response in responses) {
          final teamResponse = response['team'] as Map<String, dynamic>;
          try {
            final Team team = Team.fromJson(teamResponse);
            parsedTeams.add(team);
          } catch (error) {
            continue;
          }
        }
      }
      return parsedTeams;
    } catch (error) {
      log('Error in search_repo: ${error.toString()}');
      rethrow;
    }
  }

  Future<List<Fixture>> getLiveMatchByTeam(int teamId) async {
    log('\n\n###################################################');
    log('Schedule Match for team: $teamId');

    final List<Fixture> fixtures = [];
    final currentDate = DateTime.now();

    try {
      final response = await http.get(
          Uri.parse(
              'https://api-football-v1.p.rapidapi.com/v3/fixtures?season=2022&team=$teamId'),
          headers: header);
      if (response.statusCode == 200) {
        final responseMap = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseMap['results'] < 1) return fixtures;

        final responses = responseMap['response'] as List;

        for (final response in responses) {
          try {
            // extract Event Fields
            final int id = response['fixture']['id'];

            final String venueName = response['fixture']['venue']['name'];
            final String venueCity = response['fixture']['venue']['city'];
            final String date = response['fixture']['date'];

            final String team1 = response['teams']['home']['name'];
            final String logo1 = response['teams']['home']['logo'];
            final int id1 = response['teams']['home']['id'];

            final String team2 = response['teams']['away']['name'];
            final String logo2 = response['teams']['away']['logo'];
            final int id2 = response['teams']['away']['id'];

            ///
            final d = DateTime.parse(date);
            if (d.isBefore(currentDate)) {
              continue;
            }

            fixtures.add(Fixture(
              id: id,
              date: date,
              venueName: venueName,
              venueCity: venueCity,
              team1ID: id1,
              team2ID: id2,
              team1Name: team1,
              team2Name: team2,
              team1Logo: logo1,
              team2Logo: logo2,
            ));
          } catch (e) {
            log('Error in parsing fixture: $e');
            continue;
          }
        }
      }
    } catch (error) {
      log('Error getting match by team id: ${error.toString()}');
    }
    log('###################################################\n\n');

    return fixtures;
  }
}

import 'dart:convert';
import 'package:team_wave_assigment/Model/Country.dart';
import 'package:http/http.dart' as http;
import 'package:team_wave_assigment/Model/League.dart';
import 'package:team_wave_assigment/Model/Sport.dart';

class CountryAPIService {
  static Future<List<Leagues>?>? getLeaguesName(String countryName) async {
    var url = Uri.parse(
        "https://www.thesportsdb.com//api/v1/json/1/search_all_leagues.php?c=$countryName");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final country = Country.fromJson(jsonDecode(response.body));
      return country.leagues;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<Map<String, String>> getAllSportsName() async {
    Map<String, String> sportMap = {};
    var url =
        Uri.parse("https://www.thesportsdb.com//api/v1/json/1/all_sports.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final sports = Sport.fromJsonArray(jsonDecode(response.body)["sports"]);
      if (sports != null) {
        for (final sport in sports) {
          sportMap[sport.sportType!] = sport.backgroundImage!;
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return sportMap;
  }

  static Future<List<Leagues>?>? searchLeagues(
      String searchSport, String countryName) async {
    var url = Uri.parse(
        "https://www.thesportsdb.com//api/v1/json/1/search_all_leagues.php?s=$searchSport&c=$countryName");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final country = Country.fromJson(jsonDecode(response.body));
      return country.leagues;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

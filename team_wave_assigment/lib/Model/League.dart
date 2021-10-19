import 'package:team_wave_assigment/Model/Country.dart';

class Leagues {
  String? leagueName;
  String? leagueLogo;
  String? twitterButton;
  String? facebookButton;
  String? backgroundImage;
  String? sportType;

  static List<Leagues>? fromJsonArray(List<dynamic>? countryJsonList) {
    List<Leagues>? leagueList =
        countryJsonList?.map((e) => Leagues.fromJson(e)).toList();
    return leagueList;
  }

  Leagues.fromJson(Map<String, dynamic> json)
      : leagueName = json['strLeague'],
        sportType = json['strSport'],
        leagueLogo = json['strLogo'],
        twitterButton = json['strTwitter'],
        facebookButton = json['strFacebook'];

}

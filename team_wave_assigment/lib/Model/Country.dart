import 'package:team_wave_assigment/Model/League.dart';

class Country {
  List<Leagues>? leagues;

    Country.fromJson(Map<String, dynamic> json)
      : leagues = Leagues.fromJsonArray(json['countrys']);

}

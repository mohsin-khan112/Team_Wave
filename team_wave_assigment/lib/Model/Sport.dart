class Sport {
  String? backgroundImage;
  String? sportType;

  static List<Sport>? fromJsonArray(List<dynamic>? countryJsonList) {
    List<Sport>? sportList =
        countryJsonList?.map((e) => Sport.fromJson(e)).toList();
    return sportList;
  }

  Sport.fromJson(Map<String, dynamic> json)
      : backgroundImage = json['strSportThumb'],
        sportType = json['strSport'];
}

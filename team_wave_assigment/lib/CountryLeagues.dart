import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:team_wave_assigment/CountryAPIService.dart';
import 'package:team_wave_assigment/Model/League.dart';

class CountryLeaguesScreen extends StatefulWidget {
  final String countryName;

  CountryLeaguesScreen(this.countryName);

  @override
  _CountryLeaguesState createState() => _CountryLeaguesState();
}

class _CountryLeaguesState extends State<CountryLeaguesScreen> {
  List<Leagues?>? leagues;
  Map<String, String> sportsMap = {};
  bool isLoading = true;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _countryLeaguesDetails();
  }

  _countryLeaguesDetails() async {
    sportsMap = await CountryAPIService.getAllSportsName();
    _loadAllLeagues();
  }

  _loadAllLeagues() async {
    var leaguesData =
        await CountryAPIService.getLeaguesName(widget.countryName);
    setState(() {
      leagues = leaguesData;
      isLoading = false;
      isVisible = false;
    });
  }

  _handleSearch(
    String value,
  ) async {
    if (value.isNotEmpty) {
      setState(() {
        isLoading = true;
        leagues = [];
      });
      final searchList =
          await CountryAPIService.searchLeagues(value, widget.countryName);
      setState(() {
        leagues = searchList ?? [];
        isLoading = false;
      });
    } else {
      _loadAllLeagues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 8),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                child: TextField(
                    decoration: InputDecoration(
                      fillColor: Color(0xffEFEFEF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xffd9d9d9)),
                      ),
                      hintText: "Search league by sports name... ",
                      hintStyle: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    onChanged: _handleSearch),
              ),
              isLoading
                  ? Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Expanded(
                      child: leagues?.length != null && leagues!.length > 0
                          ? ListView.builder(
                              itemCount: leagues?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Card(
                                    color: Colors.white,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(sportsMap[
                                                  leagues?[index]?.sportType] ??
                                              ""),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            leagues?[index]?.leagueName ?? "",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: Opacity(
                                              opacity:
                                                  leagues?[index]?.leagueLogo !=
                                                          null
                                                      ? 1
                                                      : 0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Image.network(
                                                      leagues?[index]
                                                              ?.leagueLogo ??
                                                          "",
                                                      width: 120,
                                                      height: 50,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SvgPicture.asset(
                                                "assets/twitter.svg",
                                                width: 50,
                                                height: 50,
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              SvgPicture.asset(
                                                "assets/facebook.svg",
                                                width: 50,
                                                height: 50,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : Center(child: Text("Leagues Not Found"),),)
            ],
          )),
    );
  }
}

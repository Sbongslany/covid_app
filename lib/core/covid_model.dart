class CovidData {
  final String date;
  final int totalConfirmedCases;
  final int totalDeaths;
  final int totalRecovered;
  final int activeCases;
  final int dailyConfirmedCases;
  final int dailyDeaths;

  CovidData({
    required this.date,
    required this.totalConfirmedCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.activeCases,
    required this.dailyConfirmedCases,
    required this.dailyDeaths,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
      date: json['Date'],
      totalConfirmedCases: json['Total Confirmed Cases'],
      totalDeaths: json['Total Deaths'],
      totalRecovered: json['Total Recovered'],
      activeCases: json['Active Cases'],
      dailyConfirmedCases: json['Daily Confirmed Cases'],
      dailyDeaths: json['Daily  deaths'],
    );
  }
}
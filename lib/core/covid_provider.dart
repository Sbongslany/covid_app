// covid_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'covid_model.dart';

class CovidDataProvider extends ChangeNotifier {
  List<CovidData> _covidData = [];

  List<CovidData> get covidData => _covidData;

  Future<void> loadCovidData(BuildContext context) async {
    try {
      final String response = await rootBundle.loadString('assets/covid.json');
      final data = json.decode(response);
      if (data != null) {
        _covidData = List<CovidData>.from(data.map((x) => CovidData.fromJson(x)));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading covid data: $e');
      // Handle error as needed
    }
  }
}

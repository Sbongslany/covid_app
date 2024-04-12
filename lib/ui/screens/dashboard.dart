import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

import 'package:flutter/services.dart';

import '../../core/covid_model.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<CovidData> covidDataList = [];

  @override
  void initState() {
    super.initState();
    _loadCovidData();
  }

  Future<void> _loadCovidData() async {
    try {
      final String data = await rootBundle.loadString('assets/covid.json');
      List<dynamic> jsonList = json.decode(data);
      setState(() {
        covidDataList = jsonList.map((data) => CovidData.fromJson(data)).toList();
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  List<charts.Series<CovidData, String>> _createSeries() {
    return [
      charts.Series<CovidData, String>(
        id: 'Confirmed Cases',
        data: covidDataList,
        domainFn: (CovidData data, _) => data.date,
        measureFn: (CovidData data, _) => data.totalConfirmedCases,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (CovidData data, _) => '${data.totalConfirmedCases}',
      ),
      charts.Series<CovidData, String>(
        id: 'Deaths',
        data: covidDataList,
        domainFn: (CovidData data, _) => data.date,
        measureFn: (CovidData data, _) => data.totalDeaths,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        labelAccessorFn: (CovidData data, _) => '${data.totalDeaths}',
      ),
      charts.Series<CovidData, String>(
        id: 'Recovered',
        data: covidDataList,
        domainFn: (CovidData data, _) => data.date,
        measureFn: (CovidData data, _) => data.totalRecovered,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        labelAccessorFn: (CovidData data, _) => '${data.totalRecovered}',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Bar Chart'),
      ),
      body: Center(
        child: Container(
          height: 400,
          padding: EdgeInsets.all(16.0),
          child: covidDataList.isEmpty
              ? CircularProgressIndicator()
              : charts.BarChart(
            _createSeries(),
            animate: true,
            barGroupingType: charts.BarGroupingType.grouped,
            behaviors: [charts.SeriesLegend()],
            domainAxis: const charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelRotation: 45,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

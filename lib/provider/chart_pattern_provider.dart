// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/chart_data.dart';

class ChartProvider with ChangeNotifier {
  String? _selectedChart;
  List<ChartData> _savedCharts = [];
  // ignore: prefer_final_fields
  Map<String, List<double>> _chartData = {};

  ChartProvider() {
    _loadSavedCharts();
  }

  String? get selectedChart => _selectedChart;
  List<ChartData> get savedCharts => _savedCharts;

  void selectChart(String chartType) {
    _selectedChart = chartType;
    notifyListeners();
  }

  List<double>? getChartData(String chartType) {
    return _chartData[chartType];
  }

  void updateChartData(String chartType, List<double> data) {
    _chartData[chartType] = data;
    notifyListeners();
  }

  Future<void> saveChartData(ChartData chartData) async {
    var box = await Hive.openBox<ChartData>('charts');
    await box.add(chartData);
    _savedCharts.add(chartData);
    notifyListeners();
  }

  Future<void> _loadSavedCharts() async {
    var box = await Hive.openBox<ChartData>('charts');
    _savedCharts = box.values.toList();
    notifyListeners();
  }
}





















// import 'package:flutter/material.dart';

// class ChartProvider with ChangeNotifier {
//   String? _selectedChart;
//   final Map<String, List<double>> _chartData = {
//     'Line Chart 1': [],
//     'Line Chart 2': [],
//     'Bar Chart 1': [],
//     'Bar Chart 2': [],
//     'Pie Chart 1': [],
//     'Pie Chart 2': [],
//   };

//   String? get selectedChart => _selectedChart;

//   List<double>? getChartData(String chartType) => _chartData[chartType];

//   void selectChart(String chartType) {
//     _selectedChart = chartType;
//     notifyListeners();
//   }

//   void updateChartData(String chartType, List<double> data) {
//     _chartData[chartType] = data;
//     notifyListeners();
//   }
// }

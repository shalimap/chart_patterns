// ignore_for_file: use_key_in_widget_constructors

import 'package:chart_patterns/screens/page_one.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/chart_data.dart';
import '../provider/chart_Pattern_Provider.dart';

class PageTwo extends StatelessWidget {
  final String chartType;
  final List<double> data;
  const PageTwo({required this.chartType, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$chartType ',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildChart(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            label: 'Go Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.save,
              color: Colors.black,
            ),
            label: 'Save Chart',
          ),
        ],
        onTap: (index) async {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageOne(),
              ),
            );
            // Navigator.pop(context);
          } else if (index == 1) {
            var chartProvider =
                Provider.of<ChartProvider>(context, listen: false);
            var chartData = ChartData(chartType, data);
            await chartProvider.saveChartData(chartData);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Chart saved successfully!'),
            ));
          }
        },
      ),
    );
  }

  Widget _buildChart() {
    switch (chartType) {
      case 'Line Chart 1':
      case 'Line Chart 2':
        return LineChart(LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: const Color.fromARGB(255, 255, 191, 1),
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ));
      case 'Bar Chart 1':
      case 'Bar Chart 2':
        return BarChart(BarChartData(
          barGroups: data
              .asMap()
              .entries
              .map((e) => BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value,
                        color: Color.fromARGB(255, 74, 3, 204),
                      )
                    ],
                  ))
              .toList(),
        ));
      case 'Pie Chart 1':
      case 'Pie Chart 2':
        return PieChart(PieChartData(
          sections: data
              .asMap()
              .entries
              .map((e) => PieChartSectionData(
                    value: e.value,
                    color: Colors.primaries[e.key % Colors.primaries.length],
                    title: '${e.value}',
                  ))
              .toList(),
        ));
      default:
        return Container();
    }
  }
}

import 'package:chart_patterns/screens/page_three.dart';
import 'package:chart_patterns/screens/page_two.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/chart_Pattern_Provider.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<ChartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/image/chart.jpg'),
            ),
            const SizedBox(width: 10),
            Text(
              'Chart  Patterns',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.1,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: DropdownButton<String>(
                  hint: Text(
                    'Select a chart',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  value: chartProvider.selectedChart,
                  onChanged: (String? newValue) {
                    chartProvider.selectChart(newValue!);
                    _showInputDialog(context, newValue);
                  },
                  items: <String>[
                    'Line Chart 1',
                    'Line Chart 2',
                    'Bar Chart 1',
                    'Bar Chart 2',
                    'Pie Chart 1',
                    'Pie Chart 2'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_list,
              color: Colors.black,
            ),
            label: 'View Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save, color: Colors.black),
            label: 'Saved Charts',
          ),
        ],
        onTap: (index) {
          if (index == 0 && chartProvider.selectedChart != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageTwo(
                  chartType: chartProvider.selectedChart!,
                  data:
                      chartProvider.getChartData(chartProvider.selectedChart!)!,
                ),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageThree(),
              ),
            );
          }
        },
      ),
    );
  }

  void _showInputDialog(BuildContext context, String chartType) {
    final chartProvider = Provider.of<ChartProvider>(context, listen: false);
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Input data for $chartType',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          content: SizedBox(
            width: double.maxFinite,
            // height: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter comma separated values",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildSampleChart(chartType),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Save',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                List<double> data = _controller.text
                    .split(',')
                    .map((e) => double.tryParse(e.trim()) ?? 0)
                    .toList();
                chartProvider.updateChartData(chartType, data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageTwo(
                      chartType: chartProvider.selectedChart!,
                      data: chartProvider
                          .getChartData(chartProvider.selectedChart!)!,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSampleChart(String chartType) {
    switch (chartType) {
      case 'Line Chart 1':
        return _buildLineChartSample();
      case 'Line Chart 2':
        return _buildLineChartSample();
      case 'Bar Chart 1':
        return _buildBarChartSample();
      case 'Bar Chart 2':
        return _buildBarChartSample();
      case 'Pie Chart 1':
        return _buildPieChartSample();
      case 'Pie Chart 2':
        return _buildPieChartSample();
      default:
        return Container();
    }
  }

  Widget _buildLineChartSample() {
    return SizedBox(
      height: 100,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 3),
                const FlSpot(2, 2),
                const FlSpot(3, 4),
                const FlSpot(4, 3),
              ],
              isCurved: true,
              color: Colors.deepOrangeAccent,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartSample() {
    return SizedBox(
      height: 100,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 3)]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 2)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 5)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 4)]),
            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 6)]),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSample() {
    return SizedBox(
      height: 150,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 1,
              color: Colors.red,
              title: 'A',
            ),
            PieChartSectionData(
              value: 2,
              color: Colors.amber,
              title: 'B',
            ),
            PieChartSectionData(
              value: 3,
              color: Colors.blueAccent,
              title: 'C',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chart_patterns/provider/chart_Pattern_Provider.dart';
import 'package:chart_patterns/screens/page_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<ChartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Charts',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: chartProvider.savedCharts.length,
          itemBuilder: (context, index) {
            final chart = chartProvider.savedCharts[index];
            return ListTile(
              title: Text(chart.chartType),
              subtitle: Text(
                'Data: ${chart.data.join(', ')}',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageTwo(
                      chartType: chart.chartType,
                      data: chart.data,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

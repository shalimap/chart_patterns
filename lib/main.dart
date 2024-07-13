import 'package:chart_patterns/screens/page_one.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'models/chart_data.dart';
import 'provider/chart_Pattern_Provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChartDataAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChartProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chart Patterns',
        home: PageOne(),
      ),
    );
  }
}

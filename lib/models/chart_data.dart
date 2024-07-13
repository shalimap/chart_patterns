import 'package:hive/hive.dart';

part 'chart_data.g.dart';

@HiveType(typeId: 0)
class ChartData extends HiveObject {
  @HiveField(0)
  String chartType;

  @HiveField(1)
  List<double> data;

  ChartData(this.chartType, this.data);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Figure extends StatefulWidget {
  const Figure({super.key});
  
  @override
  State<Figure> createState() => _FigureState();
}

class _FigureState extends State<Figure>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior( enable: true);
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
   child:SfCartesianChart(
     title: ChartTitle(text: 'Flutter Chart'),
    legend: Legend(isVisible: true),
    series: getDefaultData(),
    tooltipBehavior: _tooltipBehavior,
   )
);
}
static List<LineSeries<SalesData, num>> getDefaultData() {
   final List<SalesData> chartData = <SalesData>[
     SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
     SalesData(DateTime(2006, 0, 8), 'China', 2.2, 24, 44, 550, 880),
     SalesData(DateTime(2007, 0, 22), 'USA', 3.32, 36, 48, 440, 788),
     SalesData(DateTime(2008, 0, 17), 'Japan', 4.56, 38, 50, 350, 560),
     SalesData(DateTime(2009, 0, 12), 'Russia', 5.87, 54, 66, 444, 566),
     SalesData(DateTime(2010, 0, 19), 'France', 6.8, 57, 78, 780, 650),
    SalesData(DateTime(2011, 0, 28), 'Germany', 8.5, 70, 84, 450, 800)
   ];
  return <LineSeries<SalesData, num>>[
     LineSeries<SalesData, num>(
         enableTooltip: true,
         dataSource: chartData,
         xValueMapper: (SalesData sales, _) => sales.date.day,
         yValueMapper: (SalesData sales, _) => sales.b,
         width:  2,
         
        markerSettings: MarkerSettings(
             isVisible: true,
             height:  4,
             width:  4,
             shape: DataMarkerType.circle,
             borderWidth: 3,
             borderColor: Colors.red),
         dataLabelSettings: DataLabelSettings(
             isVisible: true,)),
    //  LineSeries<SalesData, num>(
    //      enableTooltip: true,
    //      dataSource: chartData,
    //      enableAnimation: false,
    //      width: lineWidth ?? 2,
    //      xValueMapper: (SalesData sales, _) => sales.numeric,
    //      yValueMapper: (SalesData sales, _) => sales.sales2,
    //      markerSettings: MarkerSettings(
    //          isVisible: isMarkerVisible,
    //          height: markerWidth ?? 4,
    //          width: markerHeight ?? 4,
    //          shape: DataMarkerType.Circle,
    //          borderWidth: 3,
    //          borderColor: Colors.black),
    //      dataLabelSettings: DataLabelSettings(
    //          isVisible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto))
   ];
 }
  }
  class SalesData {
  SalesData(this.date, this.country, this.a,this.b,this.c,this.d,this.e);
  final DateTime date;
  final String country;
  final double a;
  final double b;
  final double c;
  final double d;
  final double e;
}

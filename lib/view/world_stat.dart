import 'package:covid_tracker/services/stats_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../model/WorldStatsModel.dart';

class WorldStatScreen extends StatefulWidget {
  const WorldStatScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatScreen> createState() => _WorldStatScreenState();
}

class _WorldStatScreenState extends State<WorldStatScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _colorsList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: statsServices.getWorldStats(),
                  builder: (context, AsyncSnapshot<WorldStatsModel>snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      print(snapshot.data!.cases);
                      return Column(
                        children: [
                          PieChart(
                            dataMap:  {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: _colorsList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                  ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                  ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff1aa260),
                              ),
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesList(),),);
                            },
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}

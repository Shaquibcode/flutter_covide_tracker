import 'package:covid_tracker/view/world_stat.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.test,
    required this.totalRecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.070),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * .05,),
                            ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                            ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                            ReusableRow(title: 'Recovered', value: widget.todayRecovered.toString()),
                            ReusableRow(title: 'Active', value: widget.active.toString()),
                            ReusableRow(title: 'Critical', value: widget.critical.toString()),
                            ReusableRow(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                            ReusableRow(title: 'Tests', value: widget.test.toString()),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(radius: 50,
                    backgroundImage: NetworkImage(widget.image),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

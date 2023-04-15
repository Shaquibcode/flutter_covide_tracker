import 'package:covid_tracker/services/stats_services.dart';
import 'package:covid_tracker/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/stats_services.dart';

class CountriesList extends StatefulWidget {
  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  hintText: 'Search country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.CountriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        active: snapshot.data![index]['active'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        test: snapshot.data![index]['tests'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        active: snapshot.data![index]['active'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        test: snapshot.data![index]['tests'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

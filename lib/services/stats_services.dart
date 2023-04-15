import 'dart:convert';

import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../model/WorldStatsModel.dart';

class StatsServices{
  Future<WorldStatsModel> getWorldStats() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesList));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
}

  Future<List<dynamic>> CountriesListApi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }
  }
}
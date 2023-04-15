// All the Api urls will be defined here, so that it is easy to call them.
import 'dart:core';

class AppUrl{

  //base url -
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  //fetch world covid states
  static const String worldStatesList = '${baseUrl}all' ;
  static const String countriesList = '${baseUrl}countries';

}
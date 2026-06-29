import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../service_model/Country_Model/country_model.dart';

class CountryProvider extends ChangeNotifier {
  List<CountryModel> countries = [];
  CountryModel? selectedCountry;

  Future<void> getCountries() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://adminbackend-1-h03r.onrender.com/api/settings/countries",
        ),
      );

      final json = jsonDecode(response.body);

      countries = (json["data"] as List)
          .map((e) => CountryModel.fromJson(e))
          .toList();

      if (countries.isNotEmpty) {
        selectedCountry = countries.firstWhere(
              (e) => e.code == "IN",
          orElse: () => countries.first,
        );
      }

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeCountry(CountryModel country) {
    selectedCountry = country;
    notifyListeners();
  }
}
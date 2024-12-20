import 'package:my_trainings_app/database/country_data.dart';
import 'package:my_trainings_app/model/country_model.dart';

class CountryRepository {
  static Future<List<Country>> getCountry() async {
    final returnResponse = CountryModel.fromJson(country);
    return returnResponse.country ?? [];
  }
}

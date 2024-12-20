import 'package:my_trainings_app/model/country_model.dart';
import 'package:my_trainings_app/repository/country_repository.dart';

class CountryViewModel {
  static Future<List<Country>> getCountry() async {
    return await CountryRepository.getCountry();
  }
}

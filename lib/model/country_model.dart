class CountryModel {
  List<Country>? country;

  CountryModel({this.country});

  CountryModel.fromJson(Map<String, dynamic> json) {
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String? country;
  String? abbreviation;

  Country({this.country, this.abbreviation});

  Country.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    abbreviation = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['abbreviation'] = abbreviation;
    return data;
  }
}

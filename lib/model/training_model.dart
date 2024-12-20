import 'package:my_trainings_app/model/country_model.dart';
import 'package:my_trainings_app/model/trainer_model.dart';

class TrainingModel {
  List<TrainingResponse>? response;

  TrainingModel({this.response});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <TrainingResponse>[];
      json['response'].forEach((v) {
        response!.add(TrainingResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrainingResponse {
  int? id;
  String? name;
  String? date;
  String? time;
  String? oldPrice;
  String? newPrice;
  Country? country;
  Trainer? trainer;
  String? imageUrl;

  TrainingResponse(
      {this.id,
      this.name,
      this.date,
      this.time,
      this.oldPrice,
      this.newPrice,
      this.country,
      this.trainer,
      this.imageUrl});

  TrainingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    oldPrice = json['oldPrice'];
    newPrice = json['newPrice'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    trainer =
        json['trainer'] != null ? Trainer.fromJson(json['trainer']) : null;
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['date'] = date;
    data['time'] = time;
    data['oldPrice'] = oldPrice;
    data['newPrice'] = newPrice;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (trainer != null) {
      data['trainer'] = trainer!.toJson();
    }
    data['imageUrl'] = imageUrl;
    return data;
  }
}

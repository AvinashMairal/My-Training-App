import 'package:my_trainings_app/database/training_data.dart';
import 'package:my_trainings_app/model/training_model.dart';

class TrainingRepository {
  static Future<List<TrainingResponse>> getTrainings(
      {required List locations,
      required List trainingNames,
      required List trainers}) async {
    List<TrainingResponse> trainingsDataList = [];
    final returnResponse = TrainingModel.fromJson(trainings);

    //filter by location
    if (locations.isNotEmpty) {
      List<TrainingResponse> filteredbyLocations =
          filterByLocation(returnResponse.response ?? [], locations);
      print(filteredbyLocations);
      trainingsDataList.addAll(filteredbyLocations);
    }

    //filter by trainingName
    if (trainingNames.isNotEmpty) {
      List<TrainingResponse> filteredbyTrainingNames =
          filterByTrainingName(returnResponse.response ?? [], trainingNames);
      print(filteredbyTrainingNames);
      trainingsDataList.addAll(filteredbyTrainingNames);
    }

    //filter by trainers
    if (trainers.isNotEmpty) {
      List<TrainingResponse> filteredbyTrainers =
          filterByTrainers(returnResponse.response ?? [], trainers);
      print(filteredbyTrainers);
      trainingsDataList.addAll(filteredbyTrainers);
    }

    //else
    if (locations.isEmpty && trainingNames.isEmpty && trainers.isEmpty) {
      print("in else condition");
      trainingsDataList.addAll(returnResponse.response ?? []);
    }

    //below statement remove duplicates from list
    return trainingsDataList.toSet().toList();
  }

  static List<TrainingResponse> filterByLocation(
      List<TrainingResponse> trainingsList, List<dynamic> locations) {
    List<TrainingResponse> filteredTrainings = [];

    for (int i = 0; i < locations.length; i++) {
      print(locations[i]['id']);

      for (int j = 0; j < trainingsList.length; j++) {
        if (trainingsList[j].country?.abbreviation == locations[i]['id']) {
          filteredTrainings.add(trainingsList[j]);
          break;
        }
      }
    }

    return filteredTrainings;
  }

  static List<TrainingResponse> filterByTrainingName(
      List<TrainingResponse> trainingsList, List<dynamic> trainingNames) {
    List<TrainingResponse> filteredTrainings = [];
    for (int i = 0; i < trainingNames.length; i++) {
      for (int j = 0; j < trainingsList.length; j++) {
        if (trainingsList[j].id == trainingNames[i]['id']) {
          filteredTrainings.add(trainingsList[j]);
          break;
        }
      }
    }
    return filteredTrainings;
  }

  static List<TrainingResponse> filterByTrainers(
      List<TrainingResponse> trainingsList, List<dynamic> trainers) {
    List<TrainingResponse> filteredTrainings = [];
    for (int i = 0; i < trainers.length; i++) {
      for (int j = 0; j < trainingsList.length; j++) {
        if (trainingsList[j].trainer?.id == trainers[i]['id']) {
          filteredTrainings.add(trainingsList[j]);
          break;
        }
      }
    }
    return filteredTrainings;
  }
}

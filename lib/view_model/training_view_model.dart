import 'package:my_trainings_app/model/training_model.dart';
import 'package:my_trainings_app/repository/training_repository.dart';

class TrainingViewModel {
  static Future<List<TrainingResponse>> getTrainingsData(
      {required List selectedLocations,
      required List selectedTrainings,
      required List selectedTrainers}) async {
    return await TrainingRepository.getTrainings(
      locations: selectedLocations,
      trainingNames: selectedTrainings,
      trainers: selectedTrainers,
    );
  }
}

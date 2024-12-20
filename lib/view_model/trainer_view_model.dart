import 'package:my_trainings_app/model/trainer_model.dart';
import 'package:my_trainings_app/repository/trainer_repository.dart';

class TrainerViewModel {
  static Future<List<Trainer>> getTrainers() async {
    return await TrainerRepository.getTrainers();
  }
}

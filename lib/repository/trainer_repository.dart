import 'package:my_trainings_app/database/trainer_data.dart';
import 'package:my_trainings_app/model/trainer_model.dart';

class TrainerRepository {
  static Future<List<Trainer>> getTrainers() async {
    final returnResponse = TrainerModel.fromJson(trainers);
    return returnResponse.trainer ?? [];
  }
}

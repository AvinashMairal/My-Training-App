class TrainerModel {
  List<Trainer>? trainer;

  TrainerModel({this.trainer});

  TrainerModel.fromJson(Map<String, dynamic> json) {
    if (json['trainer'] != null) {
      trainer = <Trainer>[];
      json['trainer'].forEach((v) {
        trainer!.add(Trainer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trainer != null) {
      data['trainer'] = trainer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trainer {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;

  Trainer({this.id, this.firstName, this.lastName, this.email, this.imageUrl});

  Trainer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

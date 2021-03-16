class ParticipantModel {
  String id;
  String first_name;
  String last_name;
  String team;
  String avatar;
  String group;

  ParticipantModel({this.id, this.first_name, this.last_name, this.team, this.avatar});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
        id: json['id'] as String,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        team: json['team'] as String,
        avatar: json['avatar'] as String);
  }
}
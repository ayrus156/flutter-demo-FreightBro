

import 'package:freight_bro_demo/participant_model.dart';

/// Grouping the API response based on the team model
class GroupModel {
  String team;
  List<ParticipantModel> participants;


  GroupModel({this.team, this.participants});

}
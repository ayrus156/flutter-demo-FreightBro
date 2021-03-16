
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freight_bro_demo/group_model.dart';
import 'package:freight_bro_demo/participant_model.dart';
import 'package:collection/collection.dart';
import 'constants.dart';

class Services {
  static Future<List<GroupModel>> fetchGroups() async {
    final response = await http.get(APPURLS.SAMPLE_URL);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    try {
      if (response.statusCode == 200) {
        List<GroupModel> list = parseGroupData(response.body);
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print(e);
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static List<GroupModel> parseGroupData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<ParticipantModel> result = parsed.map<ParticipantModel>((json) => ParticipantModel.fromJson(json)).toList();

    var newMap = groupBy(result, (obj) => obj.team);
    List<GroupModel> groups = new List<GroupModel>();
    for(var v in newMap.values) {
      GroupModel gm = GroupModel();
      gm.participants = v;
      gm.team = v[0].team;
      groups.add(gm);
    }
    return groups;
  }
}
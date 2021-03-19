import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freight_bro_demo/group_model.dart';
import 'package:freight_bro_demo/participant_model.dart';

/// Class that describes the single cell model of a Participant group
class Cell extends StatelessWidget {
  const Cell(this.groupModel);

  @required
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    /// Using card widget to display the participant group detail
    return  Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// More icon display at right corner
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 2.0, 10.0, 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
              ),
            ),

            /// Display Participant title using Listtile
            ListTile(
              title: Text(
                groupModel.team,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text('FIN, FR, PL'), //No matching fields in API response
            ),

            ///Display the group profile picture of participant
            Container(
              child: Row(
                children: getAvatars(groupModel.participants),
              ),
            ),
            /// Number of Participants
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                child: Text(groupModel.participants.length.toString() +
                    ' participants'),
              ),
            ),
          ],
        ),
    );
  }


  /// Setting the avatar based on number of images present
  /// in a participant team to display in row
  List<Widget> getAvatars(List<ParticipantModel> strings) {
    List<Widget> list = new List<Widget>();

    ///Setting the number of images to 3 to display
    for (var i = 0; i < 3 && i < strings.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), //or 15.0
          child: Container(
            height: 45.0,
            width: 40.0,
            child: Image.network(strings[i].avatar),
          ),
        ),
      )
      );
    }
    return list;
  }
}

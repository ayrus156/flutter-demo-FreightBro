import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freight_bro_demo/group_model.dart';
import 'package:freight_bro_demo/participant_model.dart';

class Cell extends StatelessWidget {
  const Cell(this.groupModel);

  @required
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {

    return  Card(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
            ListTile(
              title: Text(
                groupModel.team,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text('FIN, FR, PL'), //No matching fields in API response
            ),
            Container(
              child: Row(
                children: getAvatars(groupModel.participants),
              ),
            ),
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
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
    );
  }

  List<Widget> getAvatars(List<ParticipantModel> strings) {
    List<Widget> list = new List<Widget>();

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

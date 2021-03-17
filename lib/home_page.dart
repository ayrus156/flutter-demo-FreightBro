import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freight_bro_demo/participant_model.dart';
import 'package:freight_bro_demo/participants_view.dart';
import 'api_services.dart';
import 'common_components.dart';
import 'group_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<GroupModel>> futureGroup;
  String appBarTitle = "0 groups created";

  @override
  void initState() {
    super.initState();
    futureGroup = Services.fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.account_circle_outlined,
                color: Colors.blue,
                size: 35.0,
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListTile(
              title: const Text(
                "My Groups",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              subtitle: Text(appBarTitle,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black.withOpacity(0.6),
                  )),
            ),
          )),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          child: FutureBuilder<List<GroupModel>>(
              future: futureGroup,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  appBarTitle =
                      snapshot.data.length.toString() + ' groups created';
                  return CommonComp.homeGrid(snapshot, gridClicked);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }

                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  gridClicked(BuildContext context, GroupModel groupModel) {
    for (ParticipantModel participant in groupModel.participants) {
      participant.group = participant.first_name[0];
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParticipantListView(groupModel: groupModel),
        ));
  }
}

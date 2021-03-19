import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freight_bro_demo/constants.dart';
import 'package:freight_bro_demo/participant_model.dart';
import 'package:freight_bro_demo/participants_view.dart';
import 'api_services.dart';
import 'common_components.dart';
import 'group_model.dart';

///class tha display the Home page and loads data from API
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
    _getData();
  }

  /// Getting API response
  Future<void> _getData() async {
    futureGroup = Services.fetchGroups();
    futureGroup.then((result) {
      ///Updating the appbar title with the API response inside setState function
      setState(() {
        appBarTitle = result.length.toString() + '  groups created';
      });
    });
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

              /// Adding account icon at right corner
              child: Icon(
                Icons.account_circle_outlined,
                color: Colors.blue,
                size: 35.0,
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),

            ///Home page title
            child: ListTile(
              title: const Text(
                MESSAGES.HOME_PAGE_TITLE,
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
                ///Checking if snapshot has data
                if (snapshot.hasData) {
                  return CommonComp.homeGrid(snapshot, gridClicked);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }

                ///Display circular progress bar while getting API response
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  /// Grid click event implementation
  gridClicked(BuildContext context, GroupModel groupModel) {
    ///Grouping the participants first name for sorting
    ///it in alphabetical order
    for (ParticipantModel participant in groupModel.participants) {
      participant.group = participant.first_name[0];
    }

    ///Navigating to the participant detail page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParticipantListView(groupModel: groupModel),
        ));
  }
}

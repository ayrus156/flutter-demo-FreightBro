import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freight_bro_demo/participant_model.dart';
import 'api_services.dart';
import 'common_components.dart';
import 'group_model.dart';
import 'package:grouped_list/grouped_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<GroupModel>> futureGroup;

  @override
  void initState() {
    super.initState();
    futureGroup = Services.fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListTile(
              title: Text(
                "My Groups",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              subtitle: Text("12 groups created",
                  style: TextStyle(color: Colors.black54)),
            ),
          )),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          child: FutureBuilder<List<GroupModel>>(
              future: futureGroup,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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

class ParticipantListView extends StatefulWidget {
  final GroupModel groupModel;

  ParticipantListView({Key key, this.groupModel}) : super(key: key);
  @override
  ParticipantsGroupView createState() => ParticipantsGroupView();
}

class ParticipantsGroupView extends State<ParticipantListView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListTile(
                    title: Text(
                      "My Groups",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    subtitle: Text("12 groups created",
                        style: TextStyle(color: Colors.black54)),
                  ),
                )),
            body: GroupedListView<dynamic, String>(
              elements: widget.groupModel.participants,
              groupBy: (element) => element.group,
              groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1.first_name.compareTo(item2.first_name),
              order: GroupedListOrder.DESC,
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (c, element) {
                return Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0), //or 15.0
                            child: Container(
                              height: 45.0,
                              width: 40.0,
                              child: Image(
                                image: NetworkImage(element.avatar),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(element.first_name + ' ' +element.last_name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        )
                      ],


                    )
                    /*ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: ImageIcon(
                          NetworkImage(element.avatar)
                      ),
                      title: Text(element.first_name),
                    )*/
                  ),
                );
              },
            )));

  }
}
